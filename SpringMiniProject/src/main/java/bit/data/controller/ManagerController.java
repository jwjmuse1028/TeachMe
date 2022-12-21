package bit.data.controller;

import bit.data.dto.*;
import bit.data.service.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import util.DeleteServerPhoto;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.IOException;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class ManagerController {
    @Autowired
    LectureServiceInter lectureService;
    @Autowired
    LecDetailServiceInter lecDetailService;
    @Autowired
    UserServiceInter userService;

    @Autowired
    BoardServiceInter boardService;
    @Autowired
    MyLecJoinServiceInter myLecJoinService;
    @Autowired
    JoinBoardService joinBoardService;
    @Autowired
    ReportBoardServiceInter reportBoardServiceInter;


    //관리자 페이지로 이동(매출)
    @GetMapping("/manager/main")
    public ModelAndView managerMain() {
        ModelAndView mview = new ModelAndView();
        int mon = 0;
        //총 매출액 + 월별 그래프
        Date date = new Date();
        int year = 2023;
        int month = 10;
        List<MyLecJoinDto> list = myLecJoinService.getTotalIncom(year, mon);
        int totalincom = 0;
        int incom1 = 0; int incom2 = 0;
        int incom3 = 0; int incom4 = 0;
        int incom5 = 0; int incom6 = 0;
        int incom7 = 0; int incom8 = 0;
        int incom9 = 0; int incom10 = 0;
        int incom11 = 0; int incom12 = 0;
        for (int i = 0; i < list.size(); i++) {
            //올해 전체 수익
            totalincom += list.get(i).price;
            switch (list.get(i).lecmonth) {
                case 1:
                    incom1 += list.get(i).price; break;
                case 2:
                    incom2 += list.get(i).price; break;
                case 3:
                    incom3 += list.get(i).price; break;
                case 4:
                    incom4 += list.get(i).price; break;
                case 5:
                    incom5 += list.get(i).price; break;
                case 6:
                    incom6 += list.get(i).price; break;
                case 7:
                    incom7 += list.get(i).price; break;
                case 8:
                    incom8 += list.get(i).price; break;
                case 9:
                    incom9 += list.get(i).price; break;
                case 10:
                    incom10 += list.get(i).price; break;
                case 11:
                    incom11 += list.get(i).price; break;
                case 12:
                    incom12 += list.get(i).price; break;
            }
        }
        mview.addObject("incom1", incom1 / 1000);
        mview.addObject("incom2", incom2 / 1000);
        mview.addObject("incom3", incom3 / 1000);
        mview.addObject("incom4", incom4 / 1000);
        mview.addObject("incom5", incom5 / 1000);
        mview.addObject("incom6", incom6 / 1000);
        mview.addObject("incom7", incom7 / 1000);
        mview.addObject("incom8", incom8 / 1000);
        mview.addObject("incom9", incom9 / 1000);
        mview.addObject("incom10", incom10 / 1000);
        mview.addObject("incom11", incom11 / 1000);
        mview.addObject("incom12", incom12 / 1000);
        mview.addObject("totalincom", totalincom);
        mview.addObject("list", list);

        //총 유저수 + 이번달 강의수
        int totalLecture = lecDetailService.getLecTotalCountMonth(year, month);
        if (!(totalLecture > 0)) totalLecture = 0;
        int totalUser = userService.getUserTotalCount();
        if (!(totalUser > 0)) totalUser = 0;
        mview.addObject("totalLecture", totalLecture);
        mview.addObject("totalUser", totalUser);

//        lecture typeA 의 종류
        List<LectureDto> leclist = lectureService.getLecTypeA();
        mview.addObject("leclist", leclist);
        String lectureType = leclist.get(0).lectypea;
        for (int i = 1; i < leclist.size(); i++) {
            lectureType += ",";
            lectureType += leclist.get(i).lectypea;
        }
        mview.addObject("lectureType", lectureType);

        //과목별 총 매출 금액 구하기 (시간 되면 나중에는 자동형으로 변경해보자)
        int val0 = 0; int val1 = 0;
        int val2 = 0; int val3 = 0;
        int val4 = 0; int val5 = 0;

        for (int i = 0; i < list.size(); i++) {
            int temp = list.get(i).price;
            if (list.get(i).lectypea.equals(leclist.get(0).lectypea))
                val0 += temp;
            else if (list.get(i).lectypea.equals(leclist.get(1).lectypea))
                val1 += temp;
            else if (list.get(i).lectypea.equals(leclist.get(2).lectypea))
                val2 += temp;
            else if (list.get(i).lectypea.equals(leclist.get(3).lectypea))
                val3 += temp;
            else if (list.get(i).lectypea.equals(leclist.get(4).lectypea))
                val4 += temp;
            else if (list.get(i).lectypea.equals(leclist.get(5).lectypea))
                val5 += temp;
        }
        mview.addObject("val0", val0 / 1000);
        mview.addObject("val1", val1 / 1000);
        mview.addObject("val2", val2 / 1000);
        mview.addObject("val3", val3 / 1000);
        mview.addObject("val4", val4 / 1000);
        mview.addObject("val5", val5 / 1000);
//        System.out.println(leclist.get(0).lectypea);
        mview.setViewName("/manager/layoutManager/change");
        return mview;
    }

    //해당 월의 과목별 매출
    @GetMapping("/manager/incomByType")
    @ResponseBody
    public Map<String, Integer> imcomByType(@RequestParam(defaultValue = "0") int month, int year) {
        Map<String, Integer> map = new HashMap<>();
        List<MyLecJoinDto> list = myLecJoinService.getTotalIncom(year, month);
        List<LectureDto> leclist = lectureService.getLecTypeA();

        //과목별 총 매출 금액 구하기 (시간 되면 나중에는 자동형으로 변경해보자)
        int va0 = 0; int va1 = 0;
        int va2 = 0; int va3 = 0;
        int va4 = 0; int va5 = 0;
        for (int i = 0; i < list.size(); i++) {
            int temp = list.get(i).price;
            if (list.get(i).lectypea.equals(leclist.get(0).lectypea))
                va0 += temp;
            else if (list.get(i).lectypea.equals(leclist.get(1).lectypea))
                va1 += temp;
            else if (list.get(i).lectypea.equals(leclist.get(2).lectypea))
                va2 += temp;
            else if (list.get(i).lectypea.equals(leclist.get(3).lectypea))
                va3 += temp;
            else if (list.get(i).lectypea.equals(leclist.get(4).lectypea))
                va4 += temp;
            else if (list.get(i).lectypea.equals(leclist.get(5).lectypea))
                va5 += temp;
        }
        map.put("va0", va0);
        map.put("va1", va1);
        map.put("va2", va2);
        map.put("va3", va3);
        map.put("va4", va4);
        map.put("va5", va5);
        return map;
    }

    //커뮤니티 관리 페이지로 이동
    @GetMapping("/manager/boardControl")
    public String boardControl() {
        return "/manager/manager/boardManager";
    }

    //메뉴에서 회원관리 클릭 시 회원 목록 출력
    @GetMapping("/userlist")
    public String getUserList(@RequestParam(defaultValue = "1") int currentPage,
                              @RequestParam(value = "searchword", required = false) String searchword, //value: userlist의 name(url에서 ? 뒤에 오는 텍스트)과 일치 시킬 것 String 변수명이 일치되면 value는 생략가능
                              Model model) {
        int totalCount = userService.getUserTotalCount2(searchword);
        int perPage = 10;//한 페이지 당 보여질 글의 갯수
        int perBlock = 5;//한 블럭당 보여질 페이지의 갯수
        int startNum;//db에서 가져올 글의 시작번호(mysql은 첫글이 0번,오라클은 1번)
        int startPage;//각 블럭당 보여질 시작페이지
        int endPage;//각 블럭당 보여질 끝페이지
        int totalPage;//총 페이지수
        int no;//각 페이지 당 출력할 시작번호

        //총 페이지수를 구한다
        //총글의 개수/한페이지 당 보여질 개수로 나눔 (7/5=1)
        //나머지가 1이라도 있으면 무조건 1페이지 추가 (1+1=2페이지가 필요)
        totalPage = totalCount / perPage + (totalCount % perPage == 0 ? 0 : 1);

        //각 블럭 당 보여질 시작페이지
        //perBlock=5 일 경우 현재페이지가 1~5 일 경우는 시작페이지가 1, 끝페이지가 5
        //만약 현재페이지가 13 일 경우는 시작페이지가 11, 끝페이지가 15
        startPage = (currentPage - 1) / perBlock * perBlock + 1;
        endPage = startPage + perBlock - 1;
        //총페이지수가 23개일 경우 마지막 블럭은 끝페이지가 25가 아니라 23이라야한다
        if (endPage > totalPage) {
            endPage = totalPage;
        }

        //각 페이지에서 보여질 시작번호
        //예: 1페이지->0, 2페이지:5, 3페이지 : 10...
        startNum = (currentPage - 1) * perPage;

        //각페이지당 출력할 시작번호 구하기
        //예: 총글갯수가 23이라면  1페이지는 23,2페이지는 18,3페이지는 13...
        no = totalCount - (currentPage - 1) * perPage;
        List<UserDto> list = userService.getUserList(searchword, startNum, perPage);

        model.addAttribute("list", list);
        model.addAttribute("totalCount", totalCount);
        model.addAttribute("currentPage", currentPage);
        model.addAttribute("startPage", startPage);
        model.addAttribute("endPage", endPage);
        model.addAttribute("no", no);
        model.addAttribute("totalPage", totalPage);

        return "/manager/manager/userList";

    }

    //회원관리에서 돋보기 아이콘 클릭 시 회원상세정보로 이동
    @GetMapping("/userdetail")
    public ModelAndView userDetail(int usernum) {
        ModelAndView mview = new ModelAndView();
        UserDto userdto = userService.getUserDetailbyManager(usernum);
        List<UserLecJoinDto> joinlist = userService.getUserLecJoin(usernum);
//        System.out.println(joinlist.get(10).getLecdenum());
        mview.addObject("userdto", userdto);
        mview.addObject("joinlist", joinlist);

        mview.setViewName("/manager/manager/userDetail");
        return mview;
    }

    //회원 정보 수정폼으로 가기
    @GetMapping("/updateuserform")
    public ModelAndView updateUserForm(int usernum) {
        ModelAndView mview = new ModelAndView();

        UserDto dto = userService.getUserDetailbyManager(usernum);

//        DB(type:date)에서 timestamp로 불러올 때 형식 변경해서 읽을 수 있게 해주기
//        SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");
//        dto.setBirthday(sdf.format(dto.getBirth()));
//        System.out.println("birth:"+dto.getBirthday());

        mview.addObject("dto", dto);

        mview.setViewName("/manager/manager/updateUserForm");
        return mview;
    }

    //회원 정보 수정 후 회원 목록으로 이동
    @PostMapping("/updateuser")
    public String updateUser(UserDto dto, MultipartFile uploadphoto, HttpServletRequest request) {

        String path = request.getSession().getServletContext().getRealPath("/resources/upload");
//        System.out.println(path); //저장되는 실제 경로 확인
        String photo = uploadphoto.getOriginalFilename(); //photo는 실제 파일명
//        System.out.println(uploadphoto.getOriginalFilename()); //실제 파일명 확인
        if (uploadphoto.getOriginalFilename().equals("")) {
            dto.setUserphoto(null);
        } else {
            //String newName = ChangeName.getChangeFileName(upload.getOriginalFilename()); //파일 이름을 시간으로 변경할 때 사용
            try {
                uploadphoto.transferTo(new File(path + "/" + photo));
                dto.setUserphoto(photo);
            } catch (IllegalStateException | IOException e) {
                // TODO Auto-generated catch block
                e.printStackTrace();
            }
        }
        userService.updateUser(dto);
        return "redirect:userlist";
    }

    //회원 삭제 후 회원 목록으로 이동
    @GetMapping("/deleteuser")
    public String deleteUser(int usernum) {
        userService.deleteUser(usernum);
        return "redirect:userlist";
    }

    //회원 사진 삭제 후 수정 폼으로 이동
    @GetMapping("/deleteuserphoto")
    public String deleteUserPhoto(int usernum, HttpServletRequest request) {
        String path = request.getSession().getServletContext().getRealPath("/resources/upload"); //실제 저장 장소

        String fileName = userService.getDataByNum(usernum).getUserphoto(); //실제 파일 이름

        DeleteServerPhoto.deleteServerPhoto(path, fileName);

        userService.deleteUserPhoto(usernum);
        return "redirect:updateuserform?usernum=" + usernum;
    }

    //강좌 목록 출력
    @GetMapping("/lecturelist")
    public String getLecturelist(@RequestParam(defaultValue = "1") int currentPage,
                                 @RequestParam(value = "searchcolomn", required = false) String sc,
                                 @RequestParam(value = "searchword", required = false) String sw,
                                 Model model) { //강의 목록 출력
        int totalCount = lectureService.getTotalLectureCount(sc, sw);
        int perPage = 12;//한 페이지 당 보여질 글의 갯수
        int perBlock = 5;//한 블럭당 보여질 페이지의 갯수
        int startNum;//db에서 가져올 글의 시작번호(mysql은 첫글이 0번,오라클은 1번)
        int startPage;//각 블럭당 보여질 시작페이지
        int endPage;//각 블럭당 보여질 끝페이지
        int totalPage;//총 페이지수
        int no;//각 페이지 당 출력할 시작번호

        //총 페이지수를 구한다
        //총글의 개수/한페이지 당 보여질 개수로 나눔 (7/5=1)
        //나머지가 1이라도 있으면 무조건 1페이지 추가 (1+1=2페이지가 필요)
        totalPage = totalCount / perPage + (totalCount % perPage == 0 ? 0 : 1);

        //각 블럭 당 보여질 시작페이지
        //perBlock=5 일 경우 현재페이지가 1~5 일 경우는 시작페이지가 1, 끝페이지가 5
        //만약 현재페이지가 13 일 경우는 시작페이지가 11, 끝페이지가 15
        startPage = (currentPage - 1) / perBlock * perBlock + 1;
        endPage = startPage + perBlock - 1;
        //총페이지수가 23개일 경우 마지막 블럭은 끝페이지가 25가 아니라 23이라야한다
        if (endPage > totalPage) {
            endPage = totalPage;
        }

        //각 페이지에서 보여질 시작번호
        //예: 1페이지->0, 2페이지:5, 3페이지 : 10...
        startNum = (currentPage - 1) * perPage;

        //각페이지당 출력할 시작번호 구하기
        //예: 총글갯수가 23이라면  1페이지는 23,2페이지는 18,3페이지는 13...
        no = totalCount - (currentPage - 1) * perPage;
        List<LectureDto> list = lectureService.getLectureList(sc, sw, startNum, perPage);

        model.addAttribute("list", list);
        model.addAttribute("totalCount", totalCount);
        model.addAttribute("currentPage", currentPage);
        model.addAttribute("startPage", startPage);
        model.addAttribute("endPage", endPage);
        model.addAttribute("no", no);
        model.addAttribute("totalPage", totalPage);

        return "/manager/manager/lectureList";
    }

    //강좌 수정폼으로 이동
    @GetMapping("/updateLectureForm")
    public ModelAndView updateform(int lecnum) {
        ModelAndView mview = new ModelAndView();

        LectureDto dto = lectureService.getLectureDetail(lecnum);

        mview.addObject("dto", dto);

        mview.setViewName("/manager/manager/updateLectureForm");

        return mview;
    }

    //강좌 수정 후 강좌 목록으로 이동
    @PostMapping("/updatelecture")
    public String updateLecture(LectureDto dto, MultipartFile photoupload, HttpServletRequest request) {

        String path = request.getSession().getServletContext().getRealPath("/resources/upload");
//        System.out.println(path); //저장되는 실제 경로 확인
        String photo = photoupload.getOriginalFilename(); //photo는 실제 파일명
//        System.out.println(photoupload.getOriginalFilename()); //실제 파일명 확인
        if (photoupload.getOriginalFilename().equals("")) {
            dto.setLecphoto(null);
        } else {
            //String newName = ChangeName.getChangeFileName(upload.getOriginalFilename()); //파일 이름을 시간으로 변경할 때 사용
            try {
                photoupload.transferTo(new File(path + "/" + photo));
                dto.setLecphoto(photo);
            } catch (IllegalStateException | IOException e) {
                // TODO Auto-generated catch block
                e.printStackTrace();
            }
        }
        lectureService.updateLecture(dto);
        return "redirect:lecturelist";
    }

    //강좌 삭제 후 강좌 목록으로 이동
    @GetMapping("/deleteLecture")
    public String deleteLecture(int lecnum) {
        lectureService.deleteLecture(lecnum);
        return "redirect:lecturelist";
    }

    //강좌 등록 폼으로 이동
    @GetMapping("/addlectureform")
    public String addLecture() {
        return "/manager/manager/addLectureForm";
    }

    //강좌 등록 후 강좌 목록으로 이동
    @PostMapping("/insertlecture")
    public String insertLecture(LectureDto dto, MultipartFile photoupload, HttpServletRequest request) {
        //사진이 여러개일 때는 MultipartFile을 List로 가져와야함
        String path = request.getSession().getServletContext().getRealPath("/resources/upload");
//        System.out.println(path); //저장되는 실제 경로 확인
        String photo = photoupload.getOriginalFilename(); //photo는 실제 파일명
//        System.out.println(photoupload.getOriginalFilename()); //실제 파일명 확인
        if (photoupload.getOriginalFilename().equals("")) {
            dto.setLecphoto(null);
        } else {
            //String newName = ChangeName.getChangeFileName(upload.getOriginalFilename()); //파일 이름을 시간으로 변경할 때 사용
            try {
                photoupload.transferTo(new File(path + "/" + photo));
                dto.setLecphoto(photo);
            } catch (IllegalStateException | IOException e) {
                // TODO Auto-generated catch block
                e.printStackTrace();
            }
        }
        lectureService.insertLecture(dto);
        return "redirect:lecturelist";
    }

    //강의 상세 보기
    @GetMapping("/lectureDetail")
    public ModelAndView lectureDetail(int lecnum) {
//        System.out.println(lecnum);
        ModelAndView mview = new ModelAndView();

        LectureDto dto = lectureService.getLectureDetail(lecnum);
        List<LectureDetailJoinDto> list = lectureService.getLecturePresent(lecnum);
//        System.out.println(list.size());

        //dto로 가져오지 않고 list에서 하나씩 빼오는 방법(이 방법 취소하고 dto로 한번 더 가져와서 주석처리)
//        String typea = list.get(0).getLectypea();
//        String typeb = list.get(0).getLectypeb();
//        String lphoto = list.get(0).getLecphoto();
//        String lname = list.get(0).getLecname();
//        String tname = list.get(0).getTeaname();

//        mview.addObject("typea", typea);
//        mview.addObject("typeb", typeb);
//        mview.addObject("lphoto", lphoto);
//        mview.addObject("lname", lname);
//        mview.addObject("tname", tname);

        mview.addObject("lecnum", lecnum);
        mview.addObject("dto", dto);
        mview.addObject("list", list);
//        System.out.println(list);

        mview.setViewName("/manager/manager/lectureDetail");

        return mview;
    }

    //강의 추가폼으로 가기
    @GetMapping("/insertLectureDetailForm")
    public ModelAndView insertLectureDetailForm(int lecnum) {
        ModelAndView mview = new ModelAndView();
        LectureDto dto = lectureService.getLectureDetail(lecnum);
        List<LectureDetailJoinDto> list = lectureService.getLecturePresent(lecnum);

        mview.addObject("list", list);
        mview.addObject("dto", dto);
        mview.setViewName("/manager/manager/insertLectureDetailForm");

        return mview;
    }

    //강의 추가 후 강의 상세로 이동
    @PostMapping("/insertLectureDetail")
    public String insertLectureDetail(LecDetailDto dto, int lecnum) {
        lecDetailService.insertLectureDetail(dto);
        return "redirect:lectureDetail?lecnum=" + lecnum;
    }

    //강의 수정폼으로 이동
    @GetMapping("/updateLectureDetailForm")
    public ModelAndView updateLectureDetailForm(int lecdenum) {
        ModelAndView mview = new ModelAndView();
        LectureDetailJoinDto dto = lectureService.getLectureDetailData(lecdenum);
//        System.out.println(dto);
        mview.addObject("dto", dto);
        mview.setViewName("/manager/manager/updateLectureDetailForm");

        return mview;
    }

    @PostMapping("/updateLectureDetail")
    public String updateLectureDetail(LecDetailDto dto, int lecnum) {
        System.out.println("lecday"+dto.getLecday());
        System.out.println("price"+dto.getPrice());
        System.out.println("month"+dto.getLecmonth());
        System.out.println("lectime"+dto.getLectime());
        System.out.println(dto);
        lecDetailService.updateLectureDetail(dto);
        return "redirect:lectureDetail?lecnum=" + lecnum;
    }

    //강의 삭제 후 강의 상세로 이동
    @GetMapping("/deleteLectureDetail")
    public String deleteLectureDetail(@RequestParam(defaultValue = "0") int lecdenum,
                                      @RequestParam(defaultValue = "0") int lecnum) {
        lecDetailService.deleteLectureDetail(lecdenum);
        return "redirect:lectureDetail?lecnum=" + lecnum;
    }

    //    이번달에 개설된 강의 총 수 반환
    @GetMapping("/manager/totalLectureCount")
    @ResponseBody
    public int getLecTotalCountMonth(int lecyear, int lecmonth) {
        int result = lecDetailService.getLecTotalCountMonth(lecyear, lecmonth);
        if (!(result > 0)) result = 0;
        return result;
    }

    //관리자 메인화면에서 - 총유저수 출력
    @GetMapping("/manager/usertotalCount")
    @ResponseBody
    public int getUserTotalCount() {
        int result = userService.getUserTotalCount();
        if (!(result > 0)) result = 0;
        return result;
    }

    //커뮤니티 관리
    @GetMapping("/manager/boardList")
    @ResponseBody
    public Map<String, Object> freeBoardList(@RequestParam(defaultValue = "1") int currentPage,
                                             @RequestParam(value = "searchcolumn", required = false) String sc,    /*required = false: 값이 없을 겨우 null*/
                                             @RequestParam(value = "searchword", required = false) String sw,
                                             @RequestParam(value = "boardtype", required = false) String boardtype) {
        //페이징 처리에 필요한 변수들
        //전체 갯수
        int totalCount = boardService.getTotalCount(sc, sw, boardtype);
        int perPage = 2;//한페이지당 보여질 글의 갯수
        int perBlock = 5;//한블럭당 보여질 페이지의 갯수
        int startNum;//db에서 가져올 글의 시작번호(mysql은 첫글이 0번,오라클은 1번)
        int startPage;//각블럭당 보여질 시작페이지
        int endPage;//각 블럭당 보여질 끝페이지
        int totalPage;//총 페이지수
        int no;//각 페이지당 출력할 시작번호

        //총 페이지수를 구한다
        //총글의갯수/한페이지당보여질갯수로 나눔(7/5=1)
        //나머지가 1이라도 있으면 무조건 1페이지 추가(1+1=2페이지가 필요)
        totalPage = totalCount / perPage + (totalCount % perPage == 0 ? 0 : 1);

        //각 블럭당 보여질 시작페이지
        //perBlock=5 일경우 현재페이지가 1~5 일경우는 시작페이지가 1, 끝페이지가 5
        //만약 현재페이지가 13 일경우는 시작페이지가 11, 끝페이지가 15
        startPage = (currentPage - 1) / perBlock * perBlock + 1;
        endPage = startPage + perBlock - 1;
        //총페이지수가 23개일경우 마지막 블럭은 끝페이지가 25가 아니라 23이라야한다
        if (endPage > totalPage)
            endPage = totalPage;

        //각 페이지에서 보여질 시작번호
        //예: 1페이지->0, 2페이지:5, 3페이지 : 10...
        startNum = (currentPage - 1) * perPage;

        //각페이지당 출력할 시작번호 구하기
        //예: 총글갯수가 23이라면  1페이지는 23,2페이지는 18,3페이지는 13...
        no = totalCount - (currentPage - 1) * perPage;

        //페이지에서 보여질 글만 가져오기
        List<BoardDto> list = boardService.getPagingList(sc, sw, startNum, perPage, boardtype);

        Map<String, Object> map = new HashMap<>();
        map.put("list", list);
        map.put("totalCount", totalCount);
        map.put("currentPage", currentPage);
        map.put("startPage", startPage);
        map.put("endPage", endPage);
        map.put("no", no);
        map.put("totalPage", totalPage);


        return map;
    }

    //관리자 - 커뮤니티 게시글 관리에서 신고글 출력
    @GetMapping("/manager/reportBoardList")
    @ResponseBody
    public Map<String, Object> getReportBoardList(@RequestParam(defaultValue = "1") int currentPage,
                                                  @RequestParam(value = "searchcolumn", required = false) String sc,    /*required = false: 값이 없을 겨우 null*/
                                                  @RequestParam(value = "searchword", required = false) String sw) {

        //페이징 처리에 필요한 변수들
        //전체 갯수
//        int totalCount=0;
//        String boardtype="free";
//        totalCount+=boardService.getTotalCount(sc, sw, boardtype);
//        boardtype="ask";
//        totalCount+=boardService.getTotalCount(sc, sw, boardtype);

        List<JoinBoardDto> listcount = joinBoardService.getReportListCount();
        int totalCount = listcount.size();
        int perPage = 2;//한페이지당 보여질 글의 갯수
        int perBlock = 3;//한블럭당 보여질 페이지의 갯수
        int startNum;//db에서 가져올 글의 시작번호(mysql은 첫글이 0번,오라클은 1번)
        int startPage;//각블럭당 보여질 시작페이지
        int endPage;//각 블럭당 보여질 끝페이지
        int totalPage;//총 페이지수
        int no;//각 페이지당 출력할 시작번호

        //총 페이지수를 구한다
        //총글의갯수/한페이지당보여질갯수로 나눔(7/5=1)
        //나머지가 1이라도 있으면 무조건 1페이지 추가(1+1=2페이지가 필요)
        totalPage = totalCount / perPage + (totalCount % perPage == 0 ? 0 : 1);

        //각 블럭당 보여질 시작페이지
        //perBlock=5 일경우 현재페이지가 1~5 일경우는 시작페이지가 1, 끝페이지가 5
        //만약 현재페이지가 13 일경우는 시작페이지가 11, 끝페이지가 15
        startPage = (currentPage - 1) / perBlock * perBlock + 1;
        endPage = startPage + perBlock - 1;
        //총페이지수가 23개일경우 마지막 블럭은 끝페이지가 25가 아니라 23이라야한다
        if (endPage > totalPage) {
            endPage = totalPage;
        }

        //각 페이지에서 보여질 시작번호
        //예: 1페이지->0, 2페이지:5, 3페이지 : 10...
        startNum = (currentPage - 1) * perPage;

        //각페이지당 출력할 시작번호 구하기
        //예: 총글갯수가 23이라면  1페이지는 23,2페이지는 18,3페이지는 13...
        no = totalCount - (currentPage - 1) * perPage;

        List<JoinBoardDto> list = joinBoardService.getReportBoardList(startNum, perPage);
        Map<String, Object> map = new HashMap<>();
        map.put("list", list);
        map.put("totalCount", totalCount);
        map.put("currentPage", currentPage);
        map.put("startPage", startPage);
        map.put("endPage", endPage);
        map.put("no", no);
        map.put("totalPage", totalPage);
        return map;
    }

    //관리자 커뮤니티 관리 - 신고 횟수 초기화
    @PostMapping("/manager/revertReport")
    @ResponseBody
    public void revertReportBoard(int boardnum) {
        reportBoardServiceInter.revertReport(boardnum);
    }

    //관리자 커뮤니티 관리 - 신고 글 삭제
    @PostMapping("/manager/deleteReport")
    @ResponseBody
    public void deleteReportBoard(int boardnum) {
        boardService.deleteBoard(boardnum);
    }

}