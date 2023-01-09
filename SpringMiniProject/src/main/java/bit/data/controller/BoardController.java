package bit.data.controller;

import bit.data.dto.BoardDto;
import bit.data.service.BoardServiceInter;
import bit.data.service.LoginService;
import bit.data.service.ReboardServiceInter;
import bit.data.service.UserServiceInter;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import util.ChangeName;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;

@Controller
public class BoardController {

    @Autowired
    BoardServiceInter boardService;
    @Autowired
    ReboardServiceInter reboardService;
    @Autowired
    UserServiceInter userService;

    @Autowired
    LoginService loginService;

    @GetMapping("/board/boardForm") //게시판 작성폼
    public String boardForm(){

        return "/main/board/boardForm";
    }

    @GetMapping("/board/boardDetail") //게시판 디테일
    public ModelAndView boardDetail(int boardnum, @RequestParam(defaultValue = "1")int currentPage){

        ModelAndView mview = new ModelAndView();

        boardService.updateReadCount(boardnum);

        BoardDto dto = boardService.selectByNum(boardnum);

        int maxboardnum=boardService.getMaxNum(); //가장 최신글 보드넘버
        int minboardnum=boardService.getMinNum(); //가장 오래된글 보드넘버

        int prevboardnum;
        String prevboardsub="";
        if (boardnum>minboardnum) {
            prevboardnum = boardService.moveToPrevBoard(boardnum); //이전글 넘버
            prevboardsub = boardService.selectByNum(prevboardnum).getSubject(); //이전글 제목
        }
        int nextboardnum;
        String nextboardsub="";
        if (boardnum<maxboardnum) {
            nextboardnum = boardService.moveToNextBoard(boardnum); //다음글 넘버
            nextboardsub = boardService.selectByNum(nextboardnum).getSubject(); //다음글 제목
        }

        String userphoto="";
        try {
            userphoto = userService.getDataByNum(dto.getUsernum()).getUserphoto(); //프사임
        }catch (NullPointerException e){
            userphoto="no";
        }
        mview.addObject("dto", dto);
        mview.addObject("currentPage", currentPage);
        mview.addObject("userphoto", userphoto);
        mview.addObject("prevboardsub", prevboardsub);
        mview.addObject("nextboardsub", nextboardsub);
        mview.addObject("maxboardnum", maxboardnum);
        mview.addObject("minboardnum", minboardnum);

        mview.setViewName("/main/board/boardDetail");

        return mview;
    }


    @PostMapping("/board/insert") //게시판 추가
    public String insert(BoardDto dto, List<MultipartFile>upload, HttpServletRequest request)
    {
        String path = request.getSession().getServletContext().getRealPath("/resources/upload");

        //loging한 usernum에 해당하는 nickname 얻어서 dto에 넣기
        String nickname=userService.getDataByNum(dto.getUsernum()).getNickname();
        dto.setNickname(nickname);

        if (upload.get(0).getOriginalFilename().equals("")) {

            dto.setPhoto("no");
        } else {
            String photo = "";
            for(MultipartFile multi:upload)
            {
                String newName = ChangeName.getChangeFileName(multi.getOriginalFilename());
                photo+=newName+",";

                try {
                    Path paths= Paths.get(path+"/"+newName);
                    multi.transferTo(paths);
                   // multi.transferTo(new File(path+"/"+newName));
                } catch (Exception e) {
                    // throw new RuntimeException(e);
                }
            }
            photo = photo.substring(0, photo.length()-1);
            dto.setPhoto(photo);
        }
        boardService.insertBoard(dto);
        int maxboardnum=boardService.getMaxNum(); //가장 최신글 보드넘버

        return "redirect:boardDetail?boardnum="+maxboardnum+"&currentPage=1";
    }

    @GetMapping("/board/boardFree") //게시판 리스트 출력
    public String boardfree(
            @RequestParam(defaultValue = "1") int currentPage,
           @RequestParam(value = "searchcolumn" ,required = false) String sc,
            @RequestParam(value = "searchword" ,required = false) String sw,
            @RequestParam(value = "boardtype" ,defaultValue = "free") String boardtype,

            Model model
    )
    {
        int totalCount=boardService.getTotalCount(sc,sw, boardtype);
        int perPage=10;
        int perBlock=5;
        int startNum;
        int startPage;
        int endPage;
        int totalPage;
        int no;
        totalPage=totalCount/perPage+(totalCount%perPage==0?0:1);

        startPage=(currentPage-1)/perBlock*perBlock+1;
        endPage=startPage+perBlock-1;

        if(endPage>totalPage)
            endPage=totalPage;

        startNum=(currentPage-1)*perPage;

        no=totalCount-(currentPage-1)*perPage;

        List<BoardDto> list = boardService.getPagingList(sc, sw, startNum, perPage, boardtype);
        for(BoardDto dto:list)
        {
            int reboardcount = reboardService.getAllReboards(dto.getBoardnum()).size();
            dto.setReboardcount(reboardcount);
        }
        for(BoardDto hotdto:list)
        {
            int reboardcount = reboardService.getAllReboards(hotdto.getBoardnum()).size();
            hotdto.setReboardcount(reboardcount);
        }


        //좋아요 높은순 5개
        List<BoardDto> hotlist=boardService.getHotList();

        model.addAttribute("boardtype", boardtype);
        model.addAttribute("hotlist", hotlist);

        model.addAttribute("list", list);
        model.addAttribute("totalCount", totalCount);
        model.addAttribute("currentPage", currentPage);
        model.addAttribute("startPage", startPage);
        model.addAttribute("endPage", endPage);
        model.addAttribute("no", no);
        model.addAttribute("totalPage", totalPage);

        return "/main/board/boardFree";
    }

    @GetMapping("/board/delete")
    public String delete(int boardnum, int currentPage) //게시글 삭제
    {
        boardService.deleteBoard(boardnum);
        return "redirect:boardFree?currentPage="+currentPage;
    }

    @PostMapping("/board/update") //게시글 수정 등록하기
    public String update(BoardDto dto, int currentPage, List<MultipartFile>upload,
                         HttpServletRequest request)
    {
        String path = request.getSession().getServletContext().getRealPath("/resources/upload");

        if (upload.get(0).getOriginalFilename().equals("")) {
            dto.setPhoto(null);
        } else {
            String photo = "";
            for(MultipartFile multi:upload)
            {
                String newName = ChangeName.getChangeFileName(multi.getOriginalFilename());
                photo+=newName+",";

                try {
//                    Path paths= Paths.get(path+"/"+newName);
//                    multi.transferTo(paths);
                    multi.transferTo(new File(path+"/"+newName));
                } catch (Exception e) {
                    // throw new RuntimeException(e);
                }
            }
            photo = photo.substring(0, photo.length()-1);
            dto.setPhoto(photo);
        }
        boardService.updateBoard(dto);
        return "redirect:boardDetail?currentPage="+currentPage+"&boardnum="+dto.getBoardnum();
    }
    @GetMapping("/board/boardUpdate") //게시글 수정폼
    public String updateform(Model model, int boardnum, int currentPage)
    {
        BoardDto dto = boardService.selectByNum(boardnum);
        model.addAttribute("dto", dto);
        model.addAttribute("currentPage", currentPage);

        return "/main/board/boardUpdate";
    }

    @GetMapping("/board/prevboard")
    public String moveToPrevBoard(int currentPage, int boardnum)
    {
        boardnum=boardService.moveToPrevBoard(boardnum); //이전글 보드넘버

        return "redirect:boardDetail?boardnum="+boardnum+"&currentPage="+currentPage;
    }
    @GetMapping("/board/nextboard")
    public String moveToNextBoard(int currentPage, int boardnum)
    {
        boardnum=boardService.moveToNextBoard(boardnum); //다음글 보드넘버
        return "redirect:boardDetail?boardnum="+boardnum+"&currentPage="+currentPage;    }

}
