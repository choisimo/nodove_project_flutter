
import 'package:get/get.dart';
import 'package:nodove_flutter/src/model/cate.dart';
import 'package:nodove_flutter/src/model/chatting.dart';
import 'package:nodove_flutter/src/model/comment.dart';
import 'package:nodove_flutter/src/model/feed.dart';
import 'package:nodove_flutter/src/model/recruit.dart';
import 'package:nodove_flutter/src/model/user.dart';

class TempFeed extends GetxController{
  final RxBool isFetching = false.obs;
  RxList<RecruitFeed> feed = [
    RecruitFeed(
      id : "fjdsika3j20j",
      title : "게시글 테스트",
      images : [],
      content : "게시글 테스트입니등",
      url : "",
      createdAt : "2024-09-14 14:00:00",
      from : "2024-09-15 14:00:00",
      to : "2024-09-17 14:00:00",
      hashtags : ["개발","프론트엔드"],
      region: [],
      user: Company(
        id : "fduskfdkl",
        name : "유저",
        userId : "test",
        rating : 0,
        pos : Pos(
          lat: 35.4930,
          long : 129.4930
        ),
        createdAt: "",
        founded: "",
      )
    ),
    RecruitFeed(
      id : "fjdsika3j20j",
      title : "게시글 테스트",
      hashtags : ["개발","프론트엔드"],
      images : [],
      content : "게시글 테스트입니등",
      url : "",
      createdAt : "2024-09-14 14:00:00",
      from : "2024-09-15 14:00:00",
      to : "2024-09-17 14:00:00",
      region: [],
      user: Company(
        id : "fduskfdkl",
        userId : "test",
        name : "유저",
        rating : 0,
        pos : Pos(
          lat: 35.4930,
          long : 129.4930
        ),
        createdAt: "",
        founded: "",
      )
    ),
  ].obs;

  RxList<Feed> feedList = [
    Feed(
      id: 1,
      title : "커리어 블록이 추천하는 공모전",
      writerNick: "커리어블록",
      writerId : 6,
      writerUserId: "careerblock",
      writerProfile: "https://file.career-block.com/attach/images/logo.jpg",
      createdAt : "2024-11-14 12:12:12",
      updatedAt: "2024-11-14 12:12:12",
      content : """
        <p>
          <p>🔧📚 커리어 블록이 추천하는 공모전 리스트! 🚀✨</p>

          <p>어떤 공모전에 참여할지 고민하는 당신을 위해! 커리어 블록이 추천하는 공모전을 소개합니다! 창의력과 실력을 발휘할 수 있는 멋진 기회들을 놓치지 마세요!</p>

          <p>1️⃣ 2024 빅콘테스트 AI데이터 분석 활용 경진대회<br>
          - 접수기간 : 9월 9일 ~ 10월 25일</p>

          <p>2️⃣ 2024년 제13회 도로경관디자인 대전<br>
          - 접수기간 : 9월 2일 ~ 10월 28일 24:00</p>

          <p>3️⃣ 신한과 함께하는 AI 챌린지, AI IDEATHON<br>
          - 접수기간 : 10월 2일 ~ 10월 31일 18:00</p>

          <p>4️⃣ 제11회 전국 ICT 융합 공모전<br>
          - 접수기간 : 8월 1일 ~ 10월 31일 18:00</p>

          <p>각 공모전의 자세한 정보와 신청 방법을 확인해보세요. 다양한 공모전이 여러분의 멋진 아이디어와 도전을 기다립니다. 지금 바로 참여하세요! 💪✨</p>
        </p>
      """,
      hashtags: [
        "한국정보통신진흥협회", "데이터", "AI", "한국도로공사", "국토교통부", "한국디자인진흥원", "신한", "금융", "아이디어", "AI", "아이디어", "ICT", "디지털기술"
      ],
      defaultIndex: 1,
      imageLinks: [
        "https://file.career-block.com/attach/images/temp/cate1/01/%EA%B7%B8%EB%A6%BC01.jpg",
        "https://file.career-block.com/attach/images/temp/cate1/01/%EA%B7%B8%EB%A6%BC03.jpg",
        "https://file.career-block.com/attach/images/temp/cate1/01/%EA%B7%B8%EB%A6%BC05.jpg",
        "https://file.career-block.com/attach/images/temp/cate1/01/%EA%B7%B8%EB%A6%BC06.jpg",
        "https://file.career-block.com/attach/images/temp/cate1/01/%EA%B7%B8%EB%A6%BC07.jpg",
      ],
      private : false,
    ),
    Feed(
      id: 2,
      title : "커리어 블록이 추천하는 공모전",
      writerNick: "커리어블록",
      writerId : 6,
      writerUserId: "careerblock",
      writerProfile: "https://file.career-block.com/attach/images/logo.jpg",
      createdAt : "2024-11-14 12:12:12",
      updatedAt: "2024-11-14 12:12:12",
      content : """
        <p>
          <p>🔧📚 커리어 블록이 추천하는 공모전 리스트! 🚀✨</p>

          <p>어떤 공모전에 참여할지 고민하는 당신을 위해! 커리어 블록이 추천하는 공모전을 소개합니다! 창의력과 실력을 발휘할 수 있는 멋진 기회들을 놓치지 마세요!</p>

          <p>1️⃣ 2024 NH 투자증권 빅데이터 경진대회<br>
          - 접수기간 : 9월 2일 ~ 10월 11일 08:00</p>

          <p>2️⃣ DIVE 2024 (글로벌 데이터 해커톤 대회)<br>
          - 대회기간 : 10월 4일 ~ 10월 6일 (무박 3일)</p>

          <p>3️⃣ 제5회 재미있는 건축 아이디어 공모전<br>
          - 접수기간 : 8월 1일 ~ 10월 31일</p>

          <p>각 공모전의 자세한 정보와 신청 방법을 확인해보세요. 다양한 공모전이 여러분의 멋진 아이디어와 도전을 기다립니다. 지금 바로 참여하세요! 💪✨</p>
        </p>
      """,
      defaultIndex: 4,
      hashtags: ["건축", "국토교통부", "인공지능", "빅데이터", "해커톤"],
      imageLinks: [
        "https://file.career-block.com/attach/images/temp/cate1/02/%EA%B7%B8%EB%A6%BC08.jpg",
        "https://file.career-block.com/attach/images/temp/cate1/02/%EA%B7%B8%EB%A6%BC09.jpg",
        "https://file.career-block.com/attach/images/temp/cate1/02/%EA%B7%B8%EB%A6%BC10.jpg",
        "https://file.career-block.com/attach/images/temp/cate1/02/%EA%B7%B8%EB%A6%BC11.jpg",
        "https://file.career-block.com/attach/images/temp/cate1/02/%EA%B7%B8%EB%A6%BC12.jpg",
      ],
      private : false,
    ),
    Feed(
      id: 3,
      title : "커리어 블록이 추천하는 공모전",
      writerNick: "커리어블록",
      writerId : 6,
      writerUserId: "careerblock",
      writerProfile: "https://file.career-block.com/attach/images/logo.jpg",
      createdAt : "2024-11-14 12:12:12",
      updatedAt: "2024-11-14 12:12:12",
      content : """
        <p>
          <p>🔧📚 커리어 블록이 추천하는 공모전 리스트! 🚀✨</p>

          <p>어떤 공모전에 참여할지 고민하는 당신을 위해! 커리어 블록이 추천하는 공모전을 소개합니다! 창의력과 실력을 발휘할 수 있는 멋진 기회들을 놓치지 마세요!</p>

          <p>1️⃣ 2024 한국도로공사 정원디자인 공모전<br>
          - 접수기간 : 8월 12일 ~ 8월 21일</p>

          <p>2️⃣ 2024년 해양폐기물 새활용 제품 아이디어 공모전<br>
          - 접수기간 : 7월 11일 ~ 8월 23일</p>

          <p>3️⃣ 2024 대한민국 물산업 혁신 창업대전<br>
          - 접수기간 : 8월 1일 ~ 9월 4일</p>

          <p>4️⃣ 2024 정보보호 정책제안 공모전<br>
          - 접수기간 : 7월 17일 ~ 9월 30일</p>

          <p>각 공모전의 자세한 정보와 신청 방법을 확인해보세요. 다양한 공모전이 여러분의 멋진 아이디어와 도전을 기다립니다. 지금 바로 참여하세요! 💪✨</p>
        </p>
      """,
      hashtags: ["한국도로공사", "조경학과", "디자인", "해양수산부", "해양환경공단", "아이디어", "한국수자원공사", "환경부", "물산업", "과학기술정보통신부", "한국정보보호산업협회", "정보보호", "컴퓨터공학과", "공모전"],
      defaultIndex: 1,
      imageLinks: [
        "https://file.career-block.com/attach/images/temp/cate1/03/%EA%B7%B8%EB%A6%BC13.jpg",
        "https://file.career-block.com/attach/images/temp/cate1/03/%EA%B7%B8%EB%A6%BC14.jpg",
        "https://file.career-block.com/attach/images/temp/cate1/03/%EA%B7%B8%EB%A6%BC15.jpg",
        "https://file.career-block.com/attach/images/temp/cate1/03/%EA%B7%B8%EB%A6%BC16.jpg",
        "https://file.career-block.com/attach/images/temp/cate1/03/%EA%B7%B8%EB%A6%BC17.jpg",
      ],
      private : false,
    ),
    Feed(
      id: 4,
      title : "커리어 블록이 추천하는 공모전",
      writerNick: "커리어블록",
      writerId : 6,
      writerUserId: "careerblock",
      writerProfile: "https://file.career-block.com/attach/images/logo.jpg",
      createdAt : "2024-11-14 12:12:12",
      updatedAt: "2024-11-14 12:12:12",
      content : """
        <p>
          <p>🔧📚 커리어 블록이 추천하는 공모전 리스트! 🚀✨</p>

          <p>어떤 공모전에 참여할지 고민하는 당신을 위해! 커리어 블록이 추천하는 공모전들을 소개합니다! 창의력과 실력을 발휘할 수 있는 멋진 기회들을 놓치지 마세요!</p>

          <p>1️⃣ 2024 국방기술을 활용한 창업경진대회<br>
          - 신청기간 : 5월 10일 ~ 6월 26일</p>

          <p>2️⃣ 2024 GH 공간복지 청년 공모전<br>
          - 신청기간 : 6월 3일 ~ 6월 28일 18:00</p>

          <p>3️⃣ 2024년 제5회 AI•ICT 장애인 보조공학기기 공모전<br>
          - 신청기간 : 5월 7일 ~ 7월 1일</p>

          <p>4️⃣ 2024 제19회 한국농촌건축대전<br>
          - 신청기간 : 5월 4일 ~ 7월 5일</p>

          <p>각 공모전의 자세한 정보와 신청 방법을 확인해보세요. 다양한 공모전이 여러분의 멋진 아이디어와 도전을 기다립니다. 지금 바로 참여하세요! 💪✨</p>
        </p>
      """,
      defaultIndex: 1,
      hashtags: ["공모전", "창의성", "창업", "건축", "토목", "도시", "AI", "ICT", "한국농어촌공사", "경진대회"],
      imageLinks: [
        "https://file.career-block.com/attach/images/temp/cate1/04/%EA%B7%B8%EB%A6%BC18.jpg",
        "https://file.career-block.com/attach/images/temp/cate1/04/%EA%B7%B8%EB%A6%BC19.jpg",
        "https://file.career-block.com/attach/images/temp/cate1/04/%EA%B7%B8%EB%A6%BC20.jpg",
        "https://file.career-block.com/attach/images/temp/cate1/04/%EA%B7%B8%EB%A6%BC21.jpg",
        "https://file.career-block.com/attach/images/temp/cate1/04/%EA%B7%B8%EB%A6%BC22.jpg",
      ],
      private : false,
    ),
  ].obs;

  RxList<Feed> feedListb = [
    Feed(
      id: 5,
      title : "🗓️ 커리어 블록이 추천하는 대외활동 🗓️",
      writerNick: "커리어블록",
      writerId : 6,
      writerUserId: "careerblock",
      writerProfile: "https://file.career-block.com/attach/images/logo.jpg",
      createdAt : "2024-11-14 12:12:12",
      updatedAt: "2024-11-14 12:12:12",
      content : """
        <p>
          <p>🔧📚 커리어 블록이 추천하는 대외활동 리스트! 🚀✨</p>

          <p>어떤 대외활동에 참여할지 고민하는 당신을 위해! 커리어 블록이 추천하는 대외활동을 소개합니다! 창의력과 실력을 발휘할 수 있는 멋진 기회들을 놓치지 마세요!</p>

          <p>1️⃣ 시스코 CISCO 보안 아카데미 2기<br>
          - 신청기간 : ~ 10.9 23:59 까지</p>

          <p>2️⃣ 물재생 시설운영 특화과정 교육생 모집<br>
          - 신청기간 : 9.9 ~ 10.8</p>

          <p>3️⃣ 카카오 T 신규 서비스 서포터즈 2기 모집<br>
          - 신청기간 : 9.30 ~ 10.15</p>

          <p>4️⃣ 2024 겨울 유럽 드리머즈<br>
          - 신청기간 : 선착순 마감</p>

          <p>각 대외활동의 자세한 정보와 신청 방법을 확인해보세요. 다양한 대외활동이 여러분의 멋진 아이디어와 도전을 기다립니다. 지금 바로 참여하세요! 💪✨</p>

        </p>
      """,
      defaultIndex: 1,
      hashtags: ["카카오", "서포터즈", "정보공유", "고용노동부", "한국전파진흥협회", "CISCO", "한국상하수도협회", "물재생", "하수처리", "자유여행", "외국어", "유럽"],
      imageLinks: [
        "https://file.career-block.com/attach/images/temp/cate2/01/%EA%B7%B8%EB%A6%BC23.jpg",
        "https://file.career-block.com/attach/images/temp/cate2/01/%EA%B7%B8%EB%A6%BC24.jpg",
        "https://file.career-block.com/attach/images/temp/cate2/01/%EA%B7%B8%EB%A6%BC25.jpg",
        "https://file.career-block.com/attach/images/temp/cate2/01/%EA%B7%B8%EB%A6%BC26.jpg",
        "https://file.career-block.com/attach/images/temp/cate2/01/%EA%B7%B8%EB%A6%BC27.jpg",
      ],
      private : false,
    ),
    Feed(
      id: 6,
      title : "🗓️ 커리어 블록이 추천하는 대외활동 🗓️",
      writerNick: "커리어블록",
      writerId : 6,
      writerUserId: "careerblock",
      writerProfile: "https://file.career-block.com/attach/images/logo.jpg",
      createdAt : "2024-11-14 12:12:12",
      updatedAt: "2024-11-14 12:12:12",
      content : """
        <p>
          <p>🔧📚 커리어 블록이 추천하는 대외활동 리스트! 🚀✨</p>

          <p>어떤 대외활동에 참여할지 고민하는 당신을 위해! 커리어 블록이 추천하는 대외활동을 소개합니다! 창의력과 실력을 발휘할 수 있는 멋진 기회들을 놓치지 마세요!</p>

          <p>1️⃣ 2024 Samsung AI Challenge: Machine Learning Force Fields<br>
          - 접수기간 : 7월 29일 ~ 9월 13일 09:59</p>

          <p>2️⃣ 2024 Samsung AI Challenge: Black-box Optimization<br>
          - 접수기간 : 7월 29일 ~ 9월 13일 09:59</p>

          <p>3️⃣ 제2회 신약개발 AI 경진대회<br>
          - 접수기간 : 7월 29일 ~ 9월 23일 10:00</p>

          <p>4️⃣ 2024 DATA•AI 분석경진대회<br>
          - 접수기간 : 8월 23일 ~ 10월 25일</p>

          <p>각 대외활동의 자세한 정보와 신청 방법을 확인해보세요. 다양한 대외활동이 여러분의 멋진 아이디어와 도전을 기다립니다. 지금 바로 참여하세요! 💪✨</p>

        </p>
      """,
      defaultIndex: 1,
      hashtags: ["삼성전자", "반도체", "MLFF", "AI", "알고리즘", "한국제약바이오협회", "보건복지부", "인공지능", "국가과학기술연구회", "한국과학기술정보연구원"],
      imageLinks: [
        "https://file.career-block.com/attach/images/temp/cate2/02/%EA%B7%B8%EB%A6%BC28.jpg",
        "https://file.career-block.com/attach/images/temp/cate2/02/%EA%B7%B8%EB%A6%BC29.jpg",
        "https://file.career-block.com/attach/images/temp/cate2/02/%EA%B7%B8%EB%A6%BC30.jpg",
        "https://file.career-block.com/attach/images/temp/cate2/02/%EA%B7%B8%EB%A6%BC31.jpg",
        "https://file.career-block.com/attach/images/temp/cate2/02/%EA%B7%B8%EB%A6%BC32.jpg",
      ],
      private : false,
    ),
    Feed(
      id: 7,
      title : "🗓️ 커리어 블록이 추천하는 대외활동 🗓️",
      writerNick: "커리어블록",
      writerId : 6,
      writerUserId: "careerblock",
      writerProfile: "https://file.career-block.com/attach/images/logo.jpg",
      createdAt : "2024-11-14 12:12:12",
      updatedAt: "2024-11-14 12:12:12",
      content : """
        <p>
          <p>🔧📚 커리어 블록이 추천하는 대외활동 리스트! 🚀✨</p>

          <p>어떤 대외활동에 참여할지 고민하는 당신을 위해! 커리어 블록이 추천하는 대외활동을 소개합니다! 창의력과 실력을 발휘할 수 있는 멋진 기회들을 놓치지 마세요!</p>

          <p>1️⃣ 중앙그룹 서포터즈 앙중크루 2기<br>
          - 신청기간 : 5월 27일 ~ 6월 15일</p>

          <p>2️⃣ 네카라쿠배 멘토진과 함께하는 개발프로젝트십 kernel360<br>
          - 신청기간 : 5월 30일 ~ 6월 17일</p>

          <p>3️⃣ 현대자동차그룹 2024 해피무브 the green 모집<br>
          - 신청기간 : 5월 31일 ~ 6월 17일</p>

          <p>4️⃣ 파이썬 활용 빅데이터 분석&UI 전문가 양성과정<br>
          - 신청기간 : 5월 31일 ~ 6월 25일</p>

          <p>각 대외활동의 자세한 정보와 신청 방법을 확인해보세요. 다양한 대외활동이 여러분의 멋진 아이디어와 도전을 기다립니다. 지금 바로 참여하세요! 💪✨</p>

        </p>
      """,
      defaultIndex: 1,
      hashtags: ["중앙그룹", "미디어", "신문방송", "프로그래밍", "컴퓨터공학과", "해커톤", "환경공학과", "자동차학과", "현대자동차", "자바", "파이썬"],
      imageLinks: [
        "https://file.career-block.com/attach/images/temp/cate2/03/%EA%B7%B8%EB%A6%BC33.jpg",
        "https://file.career-block.com/attach/images/temp/cate2/03/%EA%B7%B8%EB%A6%BC34.jpg",
        "https://file.career-block.com/attach/images/temp/cate2/03/%EA%B7%B8%EB%A6%BC35.jpg",
        "https://file.career-block.com/attach/images/temp/cate2/03/%EA%B7%B8%EB%A6%BC36.jpg",
        "https://file.career-block.com/attach/images/temp/cate2/03/%EA%B7%B8%EB%A6%BC37.jpg",
      ],
      private : false,
    ),
    Feed(
      id: 8,
      title : "🗓️ 커리어 블록이 추천하는 대외활동 🗓️",
      writerNick: "커리어블록",
      writerId : 6,
      writerUserId: "careerblock",
      writerProfile: "https://file.career-block.com/attach/images/logo.jpg",
      createdAt : "2024-11-14 12:12:12",
      updatedAt: "2024-11-14 12:12:12",
      content : """
        <p>
          <p>🔧📚 커리어 블록이 추천하는 대외활동 리스트! 🚀✨</p>

          <p>어떤 대외활동에 참여할지 고민하는 당신을 위해! 커리어 블록이 추천하는 대외활동들을 소개합니다! 창의력과 실력을 발휘할 수 있는 멋진 기회들을 놓치지 마세요!</p>

          <p>1️⃣ 삼양그룹 대학생 서포터즈 samyang seeds 8기<br>
          - 신청기간 : 5월 20일 - 6월 12일</p>

          <p>2️⃣ 제 18기 k-water 대학생 서포터즈<br>
          - 신청기간 : 5월 20일 - 6월 13일</p>

          <p>3️⃣ 오비맥주 마케팅스쿨 3기 신입생 모집<br>
          - 신청기간 : 5월 16일 ~ 6월 16일</p>

          <p>4️⃣ 삼성웰스토리 대학생 서포터즈 1기, 웰스토리텔러<br>
          - 신청기간 : 5월 20일 - 6월 23일</p>

          <p>각 대외활동의 자세한 정보와 신청 방법을 확인해보세요. 다양한 대외활동이 여러분의 멋진 아이디어와 도전을 기다립니다. 지금 바로 참여하세요! 💪✨</p>

        </p>
      """,
      defaultIndex: 1,
      hashtags: ["대외활동", "대학생활", "삼양그룹", "한국수자원공사", "오비맥주", "삼성웰스토리", "서포터즈", "의약바이오", "화학", "마케팅"],
      imageLinks: [
        "https://file.career-block.com/attach/images/temp/cate2/04/%EA%B7%B8%EB%A6%BC38.jpg",
        "https://file.career-block.com/attach/images/temp/cate2/04/%EA%B7%B8%EB%A6%BC39.jpg",
        "https://file.career-block.com/attach/images/temp/cate2/04/%EA%B7%B8%EB%A6%BC40.jpg",
        "https://file.career-block.com/attach/images/temp/cate2/04/%EA%B7%B8%EB%A6%BC41.jpg",
        "https://file.career-block.com/attach/images/temp/cate2/04/%EA%B7%B8%EB%A6%BC42.jpg",
      ],
      private : false,
    ),
  ].obs;

  RxList<Feed> feedListc = [
    Feed(
      id: 9,
      title : "🗓️ 2024년 8월 주요 정기 시험 일정 안내 🗓️",
      writerNick: "커리어블록",
      writerId : 6,
      writerUserId: "careerblock",
      writerProfile: "https://file.career-block.com/attach/images/logo.jpg",
      createdAt : "2024-11-14 12:12:12",
      updatedAt: "2024-11-14 12:12:12",
      content : """
        <p>
          <p>토익, 기능사, 기사, 기술사 시험 등 정기시험 일정 꼼꼼히 잘 확인하고 놓치고 후회 말고 미리미리 신청 시기를 알아두세요!</p>

          <p>📝시험 준비 중인 친구 있으면 태그 고고!📝 올해 시험도 좋은 결과 있길 커리어 블록이 응원합니다! 💪🏻🙇🏻‍♂️</p>

          <p>P.S. 시험 정보뿐 아니라 커리어에 도움 되는 꿀 정보, 바로바로 쌓고 싶다면?<br>
          <strong>@careerblock.official</strong> 팔로우! 후회하지 않을 거예요!</p>
        </p>
      """,
      defaultIndex: 1,
      hashtags: [],
      imageLinks: [
        "https://file.career-block.com/attach/images/temp/cate3/01/%EA%B7%B8%EB%A6%BC43.jpg",
        "https://file.career-block.com/attach/images/temp/cate3/01/%EA%B7%B8%EB%A6%BC44.jpg",
        "https://file.career-block.com/attach/images/temp/cate3/01/%EA%B7%B8%EB%A6%BC45.jpg",
        "https://file.career-block.com/attach/images/temp/cate3/01/%EA%B7%B8%EB%A6%BC46.jpg",
        "https://file.career-block.com/attach/images/temp/cate3/01/%EA%B7%B8%EB%A6%BC47.jpg",
      ],
      private : false,
    ),
    Feed(
      id: 10,
      title : "🗓️ 2024년 9월 주요 정기 시험 일정 안내 🗓️",
      writerNick: "커리어블록",
      writerId : 6,
      writerUserId: "careerblock",
      writerProfile: "https://file.career-block.com/attach/images/logo.jpg",
      createdAt : "2024-11-14 12:12:12",
      updatedAt: "2024-11-14 12:12:12",
      content : """
        <p>
          <p>토익, 기사, 기능사, 기술사 시험 등 정기시험 일정 꼼꼼히 잘 확인하고 놓치고 후회 말고 미리미리 신청 시기를 알아두세요!</p>

          <p>📝시험 준비 중인 친구 있으면 태그 고고!📝 올해 시험도 좋은 결과 있길 커리어 블록이 응원합니다! 💪🏻🙇🏻‍♂️</p>

          <p>P.S. 시험 정보뿐 아니라 커리어에 도움 되는 꿀 정보, 바로바로 쌓고 싶다면?<br>
          <strong>@careerblock.official</strong> 팔로우! 후회하지 않을 거예요!</p>
        </p>
      """,
      defaultIndex: 1,
      hashtags: [],
      imageLinks: [
        "https://file.career-block.com/attach/images/temp/cate3/02/%EA%B7%B8%EB%A6%BC48.jpg",
        "https://file.career-block.com/attach/images/temp/cate3/02/%EA%B7%B8%EB%A6%BC49.jpg",
        "https://file.career-block.com/attach/images/temp/cate3/02/%EA%B7%B8%EB%A6%BC50.jpg",
        "https://file.career-block.com/attach/images/temp/cate3/02/%EA%B7%B8%EB%A6%BC51.jpg",
        "https://file.career-block.com/attach/images/temp/cate3/02/%EA%B7%B8%EB%A6%BC52.jpg",
      ],
      private : false,
    ),
    Feed(
      id: 11,
      title : "🗓️ 2024년 10월 주요 정기 시험 일정 안내 🗓️",
      writerNick: "커리어블록",
      writerId : 6,
      writerUserId: "careerblock",
      writerProfile: "https://file.career-block.com/attach/images/logo.jpg",
      createdAt : "2024-11-14 12:12:12",
      updatedAt: "2024-11-14 12:12:12",
      content : """
        <p>
          <p>토익, 기사, 기능사, 기술사 시험 등 정기시험 일정 꼼꼼히 잘 확인하고 놓치고 후회 말고 미리미리 신청 시기를 알아두세요!</p>

          <p>📝시험 준비 중인 친구 있으면 태그 고고!📝 올해 시험도 좋은 결과 있길 커리어 블록이 응원합니다! 💪🏻🙇🏻‍♂️</p>

          <p>P.S. 시험 정보뿐 아니라 커리어에 도움 되는 꿀 정보, 바로바로 쌓고 싶다면?<br>
          <strong>@careerblock.official</strong> 팔로우! 후회하지 않을 거예요!</p>
        </p>
      """,
      defaultIndex: 1,
      hashtags: [],
      imageLinks: [
        "https://file.career-block.com/attach/images/temp/cate3/03/%EA%B7%B8%EB%A6%BC53.jpg",
        "https://file.career-block.com/attach/images/temp/cate3/03/%EA%B7%B8%EB%A6%BC54.jpg",
        "https://file.career-block.com/attach/images/temp/cate3/03/%EA%B7%B8%EB%A6%BC55.jpg",
        "https://file.career-block.com/attach/images/temp/cate3/03/%EA%B7%B8%EB%A6%BC56.jpg",
        "https://file.career-block.com/attach/images/temp/cate3/03/%EA%B7%B8%EB%A6%BC57.jpg",
      ],
      private : false,
    ),
    Feed(
      id: 12,
      title : "🗓️ 2024년 주요 정기 시험 일정 안내 🗓️",
      writerNick: "커리어블록",
      writerId : 6,
      writerUserId: "careerblock",
      writerProfile: "https://file.career-block.com/attach/images/logo.jpg",
      createdAt : "2024-11-14 12:12:12",
      updatedAt: "2024-11-14 12:12:12",
      content : """
        <p>
          
        </p>
      """,
      defaultIndex: 1,
      hashtags: [],
      imageLinks: [
        "https://file.career-block.com/attach/images/temp/cate3/04/%EA%B7%B8%EB%A6%BC58.jpg",
        "https://file.career-block.com/attach/images/temp/cate3/04/%EA%B7%B8%EB%A6%BC59.jpg",
        "https://file.career-block.com/attach/images/temp/cate3/04/%EA%B7%B8%EB%A6%BC60.jpg",
        "https://file.career-block.com/attach/images/temp/cate3/04/%EA%B7%B8%EB%A6%BC61.jpg",
        "https://file.career-block.com/attach/images/temp/cate3/04/%EA%B7%B8%EB%A6%BC62.jpg",
      ],
      private : false,
    ),
  ].obs;

  RxList<Categories> catelist = [
    Categories(
      categoryId : 0,
      categoryName : "공모전",
      categoryDescription : "행사와 이벤트 등의 대외적인 활동에 대한 정보를 다룹니다",
      categoryImage : "https://file.career-block.com/attach/images/temp/cate1/04/%EA%B7%B8%EB%A6%BC18.jpg",
      depth : 1,
      parentCategoryName: "",
      children : [
      ]
    ),
    Categories(
      categoryId : 1,
      categoryName : "추천 대외활동",
      categoryDescription : "커리어블록에서 여러분들에게 대외활동을 추천해드립니다 ",
      categoryImage : "https://file.career-block.com/attach/images/temp/cate2/04/%EA%B7%B8%EB%A6%BC38.jpg",
      depth : 1,
      parentCategoryName: "",
    ),
    Categories(
      categoryId : 2,
      categoryName : "기타 대외활동",
      categoryImage : "https://file.career-block.com/attach/images/temp/cate3/04/%EA%B7%B8%EB%A6%BC58.jpg",
      categoryDescription : "그 외 경험 해보지 못한 대외활동을 다룹니다",
      depth : 1,
      parentCategoryName: "",
    )
  ].obs;

  Rx<Categories> currentCate = Categories(
    categoryId : 2,
    categoryName : "테스트1",
    categoryDescription : "테스트1",
    depth : 1,
    parentCategoryName: "",
    children : [
      Categories(
      categoryId : 4,
      categoryName : "테스트2",
      categoryDescription : "테스트2",
      parentCategoryName: "테스트1",
      depth : 2,
      children: [
        Categories(
          categoryId : 8,
          categoryName : "테스트3",
          categoryDescription : "테스트3",
          depth : 3,
          parentCategoryName: "테스트2",
        )
      ]
    )
    ]
  ).obs;

  List<Room> roomlist = [
    Room(
      roomId : "룸 ID",
      user: ChatUser(
        userId: 'admin',
        username: '관리자',
        profile : "",
        lastOnline: null,
        id : "admin"
      ),
      lastMsg: ChatContent(
        chatId: 0,
        content : "마지막 메세지",
        createdAt: "2024-11-14 12:12:12"
      ),
      roomName: "관리자",
      profile : ""
    )
  ];

  Rx<User> userInfo = User(
    userId: 'careerblock',
    profile: 'https://file.career-block.com/attach/images/logo.jpg',
    role : "소속 없음",
    nickname : "커리어블록",
    certifications: [],
    groups: [],
    hashtags: ["개발","프론트엔드"],
    userActivities: null,
    birthDate: DateTime.now().microsecond,
    private : false
  ).obs;

  Rx<Feed> content = Feed(
    id: 15432432,
    title : "테스트1",
    writerNick: "커리어블록",
    writerId : 6,
    writerUserId: "careerblock",
    writerProfile: "https://file.career-block.com/attach/images/logo.jpg",
    createdAt : "2024-11-14 12:12:12",
    updatedAt: "2024-11-14 12:12:12",
    content : """<p>
      <p>토익, 기사, 기능사, 기술사 시험 등 정기시험 일정 꼼꼼히 잘 확인하고 놓치고 후회 말고 미리미리 신청 시기를 알아두세요!</p>

      <p>📝시험 준비 중인 친구 있으면 태그 고고!📝 올해 시험도 좋은 결과 있길 커리어 블록이 응원합니다! 💪🏻🙇🏻‍♂️</p>

      <p>P.S. 시험 정보뿐 아니라 커리어에 도움 되는 꿀 정보, 바로바로 쌓고 싶다면?<br>
      <strong>@careerblock.official</strong> 팔로우! 후회하지 않을 거예요!</p>
    </p>""",
    hashtags: [],
    imageLinks: [
      "https://file.career-block.com/attach/images/temp/cate3/03/%EA%B7%B8%EB%A6%BC53.jpg",
      "https://file.career-block.com/attach/images/temp/cate3/03/%EA%B7%B8%EB%A6%BC54.jpg",
      "https://file.career-block.com/attach/images/temp/cate3/03/%EA%B7%B8%EB%A6%BC55.jpg",
      "https://file.career-block.com/attach/images/temp/cate3/03/%EA%B7%B8%EB%A6%BC56.jpg",
      "https://file.career-block.com/attach/images/temp/cate3/03/%EA%B7%B8%EB%A6%BC57.jpg",
    ],
    private : false,
  ).obs;

  RxList<Comment> commentList = [
      Comment(
        commentId: 0,
        comment: "댓글 테스트1",
        writer: "커리어블록",
        createdAt: "2024-11-14 11:16:00"
      )
    ].obs;

  List<List<Feed>> comm = [
    [
      Feed(
        id: 0,
        title : "",
        writerNick: "익명0",
        writerId : 6,
        writerUserId: "",
        writerProfile: "",
        createdAt : "2024-11-14 12:12:12",
        updatedAt: "2024-11-14 12:12:12",
        commentCount: 2,
        content : 
        """
        <p>
          <p>안녕하세요</p>
          <p>저는 이제 곧 졸업을 해서 취업 준비를 해야하는 학생입니다. </p>
          <p>공기업 준비하려고 하고, 현재는 따로 알바는 하지 않고 이전에 인턴을 6개월 해서 , 실업급여 나오는 걸로 월세 내고, 생활하며 자취를 하고 있는 상황입니다.</p>
          <p>2월부터 실업급여는 끝나고, 모아둔 돈으로 월세를 내거나 그럴 수는 없는 상황이라 전주에서 자취를 계속 하려면 알바를 하면서 해야합니다.</p>
          <p>이제 방 계약기간이 2월에 끝나면 본가로 돌아가야할지 전주에 남아서 자취하면서 취업준비할지 고민입니다.</p>
        </p>
        """,
        hashtags: [],
        imageLinks: [],
        private : false,
      ),
      Feed(
        id: 1,
        title : "",
        writerNick: "익명1",
        writerId : 6,
        writerUserId: "",
        writerProfile: "",
        commentCount: 2,
        createdAt : "2024-11-14 12:12:12",
        updatedAt: "2024-11-14 12:12:12",
        content : 
        """
        <p>
          <p>스터디 구해요(저는 공기업준비중입니다)</p><br/>
          <p>의지가 약해서, 공부는 따로해도 서로 자극되어주는 스터디 만들고싶어요!</p>
          <p>조율해서 도서관, 카페등에서 같이 공부하고 안되는날은 열품타, 서로에대한 목표량정해서 같이힘낼 분!! 쪽지주세용!!</p>
          <p>저는 자격증은 거의다땄고
          공단. 공사 준비중이라 ncs, 전공필기 (경영,행정등)
          조금이라도 관심있으시면 편하게 쪽지부탁드립니다.</p>
        </p>
        """,
        hashtags: [],
        imageLinks: [],
        private : false,
      ),
      Feed(
        id: 2,
        title : "",
        writerNick: "익명2",
        writerId : 6,
        commentCount: 1,
        writerUserId: "",
        writerProfile: "",
        createdAt : "2024-11-15 12:12:12",
        updatedAt: "2024-11-15 12:12:12",
        content : 
        """
        <p>
          올해는 채용 다 끝난건가요?ㅠㅠ
        </p>
        """,
        hashtags: [],
        imageLinks: [],
        private : false,
      )
    ],
    [
      Feed(
        id: 3,
        title : "",
        writerNick: "익명3",
        writerId : 6,
        commentCount: 2,
        writerUserId: "",
        writerProfile: "",
        createdAt : "2024-11-14 12:12:12",
        updatedAt: "2024-11-14 12:12:12",
        content : 
        """
        <p>
          <p>금융권 사기업 희망 합니다</p>
          <p>학점 3.6</p>
          <p>토익 850</p>
          <p>한국사1급</p>
          <p>신용분석사</p>
          <p>투자자산운용사 물류관리사</p>
          <p>스펙 이정도인데 인턴하고 대외활동은 없습니다.. 자격증에만 집중하느라 전북은행이나 4대시중은행 원하는데 이정도면 필기에만 집중할까요?</p>
        </p>
        """,
        hashtags: [],
        imageLinks: [],
        private : false,
      ),
      Feed(
        id: 4,
        title : "",
        writerNick: "익명4",
        writerId : 6,
        writerUserId: "",
        writerProfile: "",
        commentCount: 1,
        createdAt : "2024-11-14 12:12:12",
        updatedAt: "2024-11-14 12:12:12",
        content : 
        """
        <p>
          <p>경제학 관련한 활동 어떤 걸 추천하시나요?</p>
          <p>저는 사기업 취업보다는 대학원 진학 or 금융공기업을 목표로 하고 있습니다.</p>
          <p>경제 관련한 일반적인 대외활동도 좋고 아카데믹한 활동이면 더 좋을 것 같습니다!</p>
          <p>다만, 이제 2학년 올라가는 감자다 보니 많이 어려운 활동은 아직은 버거울 것 같습니다ㅠㅠ</p>
          <p>현재는 통화정책경시대회 말고는 아는 게 없어서 선배님들께 조언을 얻어보고자 글 올려봅니다.</p>
          <p>감사합니다.</p>
        </p>
        """,
        hashtags: [],
        imageLinks: [],
        private : false,
      ),
      Feed(
        id: 5,
        title : "",
        writerNick: "익명5",
        writerId : 6,
        commentCount: 1,
        writerUserId: "",
        writerProfile: "",
        createdAt : "2024-11-15 12:12:12",
        updatedAt: "2024-11-15 12:12:12",
        content : 
        """
        <p>
          <p>사기업 채용도 추가합격같은 게 존재하나요..?</p>
          <p>입시 때처럼 예비번호 쭉 뽑아놓는 건 아닌 거 같아서 문득 궁금해 여쭤봅니다 그냥 합격/ 불합격 밖에 없는 건가요</p>
        </p>
        """,
        hashtags: [],
        imageLinks: [],
        private : false,
      ),
    ],
    [
      Feed(
        id: 6,
        title : "",
        writerNick: "익명6",
        writerId : 6,
        commentCount: 1,
        writerUserId: "",
        writerProfile: "",
        createdAt : "2024-11-14 12:12:12",
        updatedAt: "2024-11-14 12:12:12",
        content : 
        """
        <p>
          <p>질문 받아주라!</p>
          <p>공공기관에 넣을 생각인데</p>
          <p>공공기관에 가려고 해도 인턴이나 대외활동(공모전) 필수 인거니??</p>
          <p>ncs랑 취준할 때 필요한 자격증 등만 가지고 있어도 돼??</p>
          <p>이제 4-2학기되고 토익한국사, 대외활동이랑 서포터즈 했던거</p>
          <p>3개정도 있는데 컴활 없어서 컴활 딸 예정이야ㅠㅠ 4-2학기 다니면서 컴활이랑 자소서 준비하면서 ncs준비만 해도 될지, 혹은 인턴 계획도 세워야 할지,.갈피를 못 잡고 있어서 조언 부탁해</p>
        </p>
        """,
        hashtags: [],
        imageLinks: [],
        private : false,
      ),
      Feed(
        id: 7,
        title : "",
        writerNick: "익명7",
        writerId : 6,
        commentCount: 2,
        writerUserId: "",
        writerProfile: "",
        createdAt : "2024-11-14 12:12:12",
        updatedAt: "2024-11-14 12:12:12",
        content : 
        """
        <p>
          <p>제가 이제 곧 4학년 2학기인데 대외활동, 공모전이 없습니다.</p>
          <p>아직 직무도 못 정했고 어학 정도 자격증만 있는 삳태인데 대외 활동이랑 공모전을 한 개씩은 준비해보려고 해요.</p>
          <p>근데 문제는 해외봉사활동이나 학생회 정도만 해보았지 서포터즈, 기자단 같은 대외활동 경험이 전무하기도 하고, 핑계지만 같이 할 만한 친구나 선배도 없어서 여태껏 안 한게 후회가 되네요.</p>
          <p>혹시 혼자서도 많이들 하시나요? 혹은 같이 할 만한 분들을 찾으려면 어떻게 찾는게 나을까요??</p>
        </p>
        """,
        hashtags: [],
        imageLinks: [],
        private : false,
      ),
      Feed(
        id: 8,
        title : "",
        writerNick: "익명8",
        writerId : 6,
        commentCount: 2,
        writerUserId: "",
        writerProfile: "",
        createdAt : "2024-11-14 12:12:12",
        updatedAt: "2024-11-14 12:12:12",
        content : 
        """
        <p>
          국민연금공단이나 건강보험공단 같은 공기업 지원할 때 도움 되는 대외활동 추천해주실 분 있나요?
        </p>
        """,
        hashtags: [],
        imageLinks: [],
        private : false,
      ),
    ]
  ];

  Map<String,List<Feed>> tagList = {
    "토목공학" : [
      Feed(
        id: 0,
        title : "한국국토정보공사가 주최하는 국토정보 SET-UP",
        writerNick: "커리어블록",
        writerId : 6,
        writerUserId: "careerblock",
        writerProfile: "https://file.career-block.com/attach/images/logo.jpg",
        createdAt : "2024-11-14 12:12:12",
        updatedAt: "2024-11-14 12:12:12",
        content : 
        """
        <p>
          <p><strong>활동에 지원하게 된 계기는?</strong></p> <ul> <li>한국국토정보공사에 취업을 희망</li> <li>한국국토정보공사에 대해 자세히 알고 싶음</li> <li>활동 참여 시 2학점 취득</li> </ul> <p><strong>구체적인 활동 내용</strong></p> <p>직접적으로 경험한 활동은 지적측량 기계인 토탈스테이션을 직접 설치하고 간단하게 사용해봤습니다. 간접적으로는 현재 국토정보공사의 주요 사업은 디지털 트윈이고, 이러한 디지털 트윈을 이용해 자율주행 관련해서도 많은 연구를 하고 있다는 것을 알게 되었습니다. 또한, 지적 산업은 토탈스테이션 측량에서 드론을 이용한 측량으로 넘어가는 시기에 있고, 드론을 이용한 측량의 장단점에 대해 듣게 되었습니다.</p> <p><strong>활동을 통해 배운 점/역량</strong></p> <p>강의를 들으면서 지적측량의 미래와 국토정보공사의 미래에 대한 정보를 습득하게 되었습니다. 지적학은 현재 미래로 나아가는 상황이고, 그 중심에 드론이 있다는 사실을 알게 되었고, 드론을 통해 측량을 하고 관측한 정보들을 프로그램을 통해 3D로 나타낼 수 있다는 것을 배우게 되었습니다. 토탈스테이션 측량도 직접 해보고, 랜디고(국토정보공사 프로그램)도 간단히 사용해보면서 측량을 통해 얻은 정보를 처리하는 방법을 배웠습니다.</p> <p><strong>활동 관련 키워드</strong></p> <ul> <li>#드론 산업</li> <li>#디지털 트윈</li> <li>#정보 처리</li> <li>#토목공학과</li> </ul> <p><strong>이런 분들께 추천해요</strong></p> <ul> <li>공간정보에 관심이 있는 분들</li> <li>드론에 관심이 많은 분들</li> <li>국토정보공사에 관심은 있지만 아는 정보는 적은 분들</li> </ul>
        </p>
        """,
        hashtags: [
          "토목공학"
        ],
        defaultIndex: 0,
        imageLinks: [
          "https://file.career-block.com/attach/images/temp/hashtag1/01/%EA%B7%B8%EB%A6%BC63.jpg",
          "https://file.career-block.com/attach/images/temp/hashtag1/01/%EA%B7%B8%EB%A6%BC64.jpg",
          "https://file.career-block.com/attach/images/temp/hashtag1/01/%EA%B7%B8%EB%A6%BC65.jpg",
          "https://file.career-block.com/attach/images/temp/hashtag1/01/%EA%B7%B8%EB%A6%BC66.jpg",
          "https://file.career-block.com/attach/images/temp/hashtag1/01/%EA%B7%B8%EB%A6%BC67.jpg",
        ],
        private : false,
      ),
      Feed(
        id: 1,
        title : "대한토목학회 스마트건설 기술교육",
        writerNick: "커리어블록",
        writerId : 6,
        writerUserId: "careerblock",
        writerProfile: "https://file.career-block.com/attach/images/logo.jpg",
        createdAt : "2024-11-14 12:12:12",
        updatedAt: "2024-11-14 12:12:12",
        content : 
        """
        <p>
          대한토목학회, 한국도로공사 스마트건설사업단. 한국건설자동화로보틱스학회에서 공동 주최한 기술교육으로 BIM. OSC, 자동화, 스마트 안전기술 같은 총 4개의 세션으로 구분된 교육프로그램이다
        </p>
        """,
        hashtags: [
          "토목공학","대한토목학회","기술교육"
        ],
        defaultIndex: 0,
        imageLinks: [
          "https://file.career-block.com/attach/images/temp/hashtag1/02/%EA%B7%B8%EB%A6%BC68.jpg",
          "https://file.career-block.com/attach/images/temp/hashtag1/02/%EA%B7%B8%EB%A6%BC69.jpg",
          "https://file.career-block.com/attach/images/temp/hashtag1/02/%EA%B7%B8%EB%A6%BC70.jpg",
          "https://file.career-block.com/attach/images/temp/hashtag1/02/%EA%B7%B8%EB%A6%BC71.jpg",
          "https://file.career-block.com/attach/images/temp/hashtag1/02/%EA%B7%B8%EB%A6%BC72.jpg",
        ],
        private : false,
      ),
      Feed(
        id: 2,
        title : "한국수자원조사기술원 현장 실습",
        writerNick: "커리어블록",
        writerId : 6,
        writerUserId: "careerblock",
        writerProfile: "https://file.career-block.com/attach/images/logo.jpg",
        createdAt : "2024-11-14 12:12:12",
        updatedAt: "2024-11-14 12:12:12",
        content : 
        """
        <p>
          <p><strong>활동에 지원하게 된 계기는?</strong></p> <ul> <li>한국 수자원 조사 기술원의 대학생 현장실습 학기제 운영</li> <li>홍수기에 해당하는 여름방학에 신청하여 참여</li> </ul> <p><strong>구체적인 활동 내용</strong></p> <ul> <li>도선법을 활용한 유량조사</li> <li>교량법을 활용한 유량조사</li> <li>무인보트법을 활용한 유량조사</li> <li>횡측선법을 활용한 유량조사</li> </ul> <p><strong>활동을 통해 배운 점/역량</strong></p> <ul> <li>수위-유량관계곡선식 개발 및 활용</li> <li>연구원들의 노고 공감</li> </ul> <p><strong>활동 관련 키워드</strong></p> <ul> <li>#토목공학과</li> <li>#물</li> <li>#현장실습</li> <li>#유량조사</li> </ul>
        </p>
        """,
        hashtags: [
          "토목공학","대한토목학회","기술교육"
        ],
        defaultIndex: 0,
        imageLinks: [
          "https://file.career-block.com/attach/images/temp/hashtag1/03/%EA%B7%B8%EB%A6%BC73.jpg",
          "https://file.career-block.com/attach/images/temp/hashtag1/03/%EA%B7%B8%EB%A6%BC74.jpg",
          "https://file.career-block.com/attach/images/temp/hashtag1/03/%EA%B7%B8%EB%A6%BC75.jpg",
          "https://file.career-block.com/attach/images/temp/hashtag1/03/%EA%B7%B8%EB%A6%BC76.jpg",
          "https://file.career-block.com/attach/images/temp/hashtag1/03/%EA%B7%B8%EB%A6%BC77.jpg",
        ],
        private : false,
      ),
      Feed(
        id: 3,
        title : "열화상 센서와 드론을 활용한 블랙아이스 식별 S/W",
        writerNick: "커리어블록",
        writerId : 6,
        writerUserId: "careerblock",
        writerProfile: "https://file.career-block.com/attach/images/logo.jpg",
        createdAt : "2024-11-14 12:12:12",
        updatedAt: "2024-11-14 12:12:12",
        content : 
        """
        <p>
          <p>열화상 센서와 드론을 활용한 블랙아이스 식별 S/W</p>
          <p>전라북도 경찰청 (교통안전계 과장 및 드론 행정관)</p>
        </p>
        """,
        hashtags: [
          "토목공학", "토목재료", "교량", "블랙아이스", "창업"
        ],
        defaultIndex: 0,
        imageLinks: [
          "https://file.career-block.com/attach/images/temp/hashtag1/04/%EA%B7%B8%EB%A6%BC78.jpg",
          "https://file.career-block.com/attach/images/temp/hashtag1/04/%EA%B7%B8%EB%A6%BC79.jpg",
          "https://file.career-block.com/attach/images/temp/hashtag1/04/%EA%B7%B8%EB%A6%BC80.jpg",
        ],
        private : false,
      ),
    ],
    "건설사" : [
      Feed(
        id: 4,
        title : "2025년 현재건설 신입사원 채용",
        writerNick: "커리어블록",
        writerId : 6,
        writerUserId: "careerblock",
        writerProfile: "https://file.career-block.com/attach/images/logo.jpg",
        createdAt : "2024-11-14 12:12:12",
        updatedAt: "2024-11-14 12:12:12",
        content : "<p></p>",
        hashtags: [
          "건설사", "토목공학", "건축공학", "기계공학"
        ],
        defaultIndex: 0,
        imageLinks: [
          "https://file.career-block.com/attach/images/temp/hashtag2/01/%EA%B7%B8%EB%A6%BC81.jpg",
        ],
        private : false,
      ),
      Feed(
        id: 5,
        title : "DL이앤씨 인턴",
        writerNick: "커리어블록",
        writerId : 6,
        writerUserId: "careerblock",
        writerProfile: "https://file.career-block.com/attach/images/logo.jpg",
        createdAt : "2024-11-14 12:12:12",
        updatedAt: "2024-11-14 12:12:12",
        content : "<p></p>",
        hashtags: [
          "토목공학", "시공사", "건설사", "인턴"
        ],
        defaultIndex: 0,
        imageLinks: [
          "https://file.career-block.com/attach/images/temp/hashtag2/02/%EA%B7%B8%EB%A6%BC82.jpg",
          "https://file.career-block.com/attach/images/temp/hashtag2/02/%EA%B7%B8%EB%A6%BC83.jpg",
        ],
        private : false,
      ),
      Feed(
        id: 8,
        title : "LH 대학생 주택건축대전",
        writerNick: "커리어블록",
        writerId : 6,
        writerUserId: "careerblock",
        writerProfile: "https://file.career-block.com/attach/images/logo.jpg",
        createdAt : "2024-11-14 12:12:12",
        updatedAt: "2024-11-14 12:12:12",
        content : "<p></p>",
        hashtags: [
          "건축", "주택", "LH", "건설사", "시공사", "설계"
        ],
        defaultIndex: 0,
        imageLinks: [
          "https://file.career-block.com/attach/images/temp/hashtag2/03/%EA%B7%B8%EB%A6%BC84.jpg",
        ],
        private : false,
      ),
      Feed(
        id: 9,
        title : "2024 구조물 내진설계 경진대회",
        writerNick: "커리어블록",
        writerId : 6,
        writerUserId: "careerblock",
        writerProfile: "https://file.career-block.com/attach/images/logo.jpg",
        createdAt : "2024-11-14 12:12:12",
        updatedAt: "2024-11-14 12:12:12",
        content : "<p></p>",
        hashtags: [
          "구조물", "경진대회", "건축", "토목", "건설사", "설계사"
        ],
        defaultIndex: 0,
        imageLinks: [
          "https://file.career-block.com/attach/images/temp/hashtag2/04/%EA%B7%B8%EB%A6%BC85.jpg",
        ],
        private : false,
      ),
    ]
  };

  List<Feed> userContent = [
    Feed(
      id: 25,
      title : "드론 운용 전문가 양성과정",
      writerNick: "커리어블록",
      writerId : 6,
      writerUserId: "careerblock",
      writerProfile: "https://file.career-block.com/attach/images/logo.jpg",
      createdAt : "2024-11-14 12:12:12",
      updatedAt: "2024-11-14 12:12:12",
      content : "<p></p>",
      hashtags: [],
      defaultIndex: 0,
      imageLinks: [
        "https://file.career-block.com/attach/images/temp/myfeed/01/%EA%B7%B8%EB%A6%BC86.jpg",
        "https://file.career-block.com/attach/images/temp/myfeed/01/%EA%B7%B8%EB%A6%BC87.jpg",
      ],
      private : false,
    ),
    Feed(
      id: 3,
      title : "열화상 센서와 드론을 활용한 블랙아이스 식별 S/W",
      writerNick: "커리어블록",
      writerId : 6,
      writerUserId: "careerblock",
      writerProfile: "https://file.career-block.com/attach/images/logo.jpg",
      createdAt : "2024-11-14 12:12:12",
      updatedAt: "2024-11-14 12:12:12",
      content : 
      """
      <p>
        <p>열화상 센서와 드론을 활용한 블랙아이스 식별 S/W</p>
        <p>전라북도 경찰청 (교통안전계 과장 및 드론 행정관)</p>
      </p>
      """,
      hashtags: [
        "토목공학", "토목재료", "교량", "블랙아이스", "창업"
      ],
      defaultIndex: 0,
      imageLinks: [
        "https://file.career-block.com/attach/images/temp/hashtag1/04/%EA%B7%B8%EB%A6%BC78.jpg",
        "https://file.career-block.com/attach/images/temp/hashtag1/04/%EA%B7%B8%EB%A6%BC79.jpg",
        "https://file.career-block.com/attach/images/temp/hashtag1/04/%EA%B7%B8%EB%A6%BC80.jpg",
      ],
      private : false,
    ),
    Feed(
      id: 26,
      title : "사업 아이템 평가 및 실무진 멘토링",
      writerNick: "커리어블록",
      writerId : 6,
      writerUserId: "careerblock",
      writerProfile: "https://file.career-block.com/attach/images/logo.jpg",
      createdAt : "2024-11-14 12:12:12",
      updatedAt: "2024-11-14 12:12:12",
      content : """<p>
        <p>
        열화상 센서와 드론을 활용한
        블랙아이스 식별 S/W</p><br/>
        <p>한국도로공사 전북본부 현장 실무진</p>
      </p>""",
      hashtags: [],
      defaultIndex: 0,
      imageLinks: [
        "https://file.career-block.com/attach/images/temp/myfeed/03/%EA%B7%B8%EB%A6%BC91.jpg",
        "https://file.career-block.com/attach/images/temp/myfeed/03/%EA%B7%B8%EB%A6%BC92.jpg",
        "https://file.career-block.com/attach/images/temp/myfeed/03/%EA%B7%B8%EB%A6%BC93.jpg",
      ],
      private : false,
    ),
    Feed(
      id: 27,
      title : "동계 빅데이터 캠프",
      writerNick: "커리어블록",
      writerId : 6,
      writerUserId: "careerblock",
      writerProfile: "https://file.career-block.com/attach/images/logo.jpg",
      createdAt : "2024-11-14 12:12:12",
      updatedAt: "2024-11-14 12:12:12",
      content : """<p>
        <p>
          2024.01.08-01.12
        </p>
        <p>
          딥러닝 강화학습 모델을 활용한 자율주행
        </p>
      </p>""",
      hashtags: [
        "aws","deepracer"
      ],
      defaultIndex: 0,
      imageLinks: [
        "https://file.career-block.com/attach/images/temp/myfeed/04/%EA%B7%B8%EB%A6%BC94.jpg",
        "https://file.career-block.com/attach/images/temp/myfeed/04/%EA%B7%B8%EB%A6%BC95.jpg",
        "https://file.career-block.com/attach/images/temp/myfeed/04/%EA%B7%B8%EB%A6%BC96.jpg",
        "https://file.career-block.com/attach/images/temp/myfeed/04/%EA%B7%B8%EB%A6%BC97.jpg",
      ],
      private : false,
    ),
    Feed(
      id: 28,
      title : "제주 TBM 창업캠프",
      writerNick: "커리어블록",
      writerId : 6,
      writerUserId: "careerblock",
      writerProfile: "https://file.career-block.com/attach/images/logo.jpg",
      createdAt : "2024-11-14 12:12:12",
      updatedAt: "2024-11-14 12:12:12",
      content : """<p>
        <p>2024.01.17-01.19</p>
        <p>이음-공연예술 기회 공유 플랫폼</p>
      </p>""",
      hashtags: ["전북대학교","충남대학교","제주대학교","원광대학교"],
      defaultIndex: 0,
      imageLinks: [
        "https://file.career-block.com/attach/images/temp/myfeed/05/%EA%B7%B8%EB%A6%BC98.jpg",
        "https://file.career-block.com/attach/images/temp/myfeed/05/%EA%B7%B8%EB%A6%BC99.jpg",
        "https://file.career-block.com/attach/images/temp/myfeed/05/%EA%B7%B8%EB%A6%BC100.jpg",
      ],
      private : false,
    ),
    Feed(
      id: 29,
      title : "토목공학과 응용측량학 전공 수업",
      writerNick: "커리어블록",
      writerId : 6,
      writerUserId: "careerblock",
      writerProfile: "https://file.career-block.com/attach/images/logo.jpg",
      createdAt : "2024-11-14 12:12:12",
      updatedAt: "2024-11-14 12:12:12",
      content : """<p>
        - 드론을 활용한 사진측량 특강 -
      </p>""",
      hashtags: [],
      defaultIndex: 0,
      imageLinks: [
        "https://file.career-block.com/attach/images/temp/myfeed/06/%EA%B7%B8%EB%A6%BC101.jpg",
        "https://file.career-block.com/attach/images/temp/myfeed/06/%EA%B7%B8%EB%A6%BC102.jpg",
        "https://file.career-block.com/attach/images/temp/myfeed/06/%EA%B7%B8%EB%A6%BC103.jpg",
      ],
      private : false,
    ),
    Feed(
      id: 30,
      title : "DL E&C 토목사업본부 새만금",
      writerNick: "커리어블록",
      writerId : 6,
      writerUserId: "careerblock",
      writerProfile: "https://file.career-block.com/attach/images/logo.jpg",
      createdAt : "2024-11-14 12:12:12",
      updatedAt: "2024-11-14 12:12:12",
      content : """<p>
        - 전주 고속 7공구 토공팀 인턴 -
      </p>""",
      hashtags: [],
      defaultIndex: 0,
      imageLinks: [
        "https://file.career-block.com/attach/images/temp/myfeed/07/%EA%B7%B8%EB%A6%BC104.jpg",
      ],
      private : false,
    ),
    Feed(
      id: 31,
      title : "봉사동아리 로타랙트",
      writerNick: "커리어블록",
      writerId : 6,
      writerUserId: "careerblock",
      writerProfile: "https://file.career-block.com/attach/images/logo.jpg",
      createdAt : "2024-11-14 12:12:12",
      updatedAt: "2024-11-14 12:12:12",
      content : "",
      hashtags: [],
      defaultIndex: 0,
      imageLinks: [
        "https://file.career-block.com/attach/images/temp/myfeed/08/%EA%B7%B8%EB%A6%BC105.jpg",
        "https://file.career-block.com/attach/images/temp/myfeed/08/%EA%B7%B8%EB%A6%BC106.jpg",
      ],
      private : false,
    ),
  ];

  List<List<Comment>> commComment = [
    [
      Comment(
        comment: "지나가다가 궁금해서 여쭤보는 건데 일반 사기업/공기업 인턴도 실업급여가 나올 수 있나요? 6개월이긴 해요.",
        commentId: 0,
        writer : "익명1",
        createdAt : "2024-11-14 12:13:13"
      ),
      Comment(
        comment: "취준 기간은 누구보다 이기적일 필요가 있다고 생각해요 내가 가족을 배려한다고 해서 취업 시켜줄 것도 아니고, 나만 신경 쓰기도 힘든 시기라고 생각합니다. 다만 이기적인만큼 준비도 열심히 할 자신 있다면 전주에 남는거고, 그걸 못하겠다 하면 본가 가야죠.",
        commentId: 1,
        writer : "익명2",
        createdAt : "2024-11-14 12:13:13"
      )
    ],
    [
      Comment(
        comment: "주로 어디서공부하세영?",
        commentId: 2,
        writer : "익명1",
        createdAt : "2024-11-14 12:13:13"
      ),
      Comment(
        comment: "저도 공기업가고싶어서요! 방학때 자격증 따려고하는데 혹시 자격증 준비하신거 여쭈어봐도 될까요??",
        commentId: 3,
        writer : "익명2",
        createdAt : "2024-11-14 12:13:13"
      )
    ],
    [
      Comment(
        comment: "대부분 상반기가 끝이에요. 근데 찾아보시면 없진 않아요.",
        commentId: 5,
        writer : "익명2",
        createdAt : "2024-11-14 12:13:13"
      )
    ],
    [
      Comment(
        comment: "자격증 난이도 순서 어떻게 보시나요??",
        commentId: 6,
        writer : "익명1",
        createdAt : "2024-11-14 12:13:13"
      ),
      Comment(
        comment: "시중은행 아까운데...인턴하시고 더 높게 보시죠",
        commentId: 7,
        writer : "익명2",
        createdAt : "2024-11-14 12:13:13"
      )
    ],
    [
      Comment(
        comment: "기획재정부, 금융감독원 기자단",
        commentId: 8,
        writer : "익명1",
        createdAt : "2024-11-14 12:13:13"
      ),
    ],
    [
      Comment(
        comment: "그거는 정말로 케바케임 보통 최종전형에서 둘다붙고 딴데간 사람잇으면 대신들어갈수도 있음",
        commentId: 9,
        writer : "익명1",
        createdAt : "2024-11-14 12:13:13"
      ),
    ],
    [
      Comment(
        comment: "컴활, ncs 먼저. 전공시험 있으면 그것도. 그리고 서류필기 뚫을 정도 되면 인턴, 정규직 같이 지원해서 되는 곳 고고. 어차피 면접 내용은 비슷할테니.",
        commentId: 10,
        writer : "익명1",
        createdAt : "2024-11-14 12:13:13"
      ),
    ],
    [
      Comment(
        comment: """
          난 혼자서도 지원 많이해서 했어!
          내가 진짜 하고 싶은 것들이었어서!!
          친구는 딱히 상관 없는거 같아 경험해봤을 때 혼자 하면서 친해지는 케이스가 더 많은거 같아
        """,
        commentId: 11,
        writer : "익명1",
        createdAt : "2024-11-14 12:13:13"
      ),
      Comment(
        comment: """
          원하는 공공기관 인스타그램이나 사이트 들어가서 서포터즈 찾아서 했어! 동기들 하는 것도 봐뒀어.
          나는 문과라 홍보/디자인 이쪽 많이 했어
        """,
        commentId: 12,
        writer : "익명1",
        createdAt : "2024-11-14 12:13:13"
      ),
    ],
    [
      Comment(
        comment: """
          공기업은 대외활동 필요 없는데요 그냥 필기 ncs 잘보면 장땡이라
        """,
        commentId: 13,
        writer : "익명1",
        createdAt : "2024-11-14 12:13:13"
      ),
      Comment(
        comment: """
          필요한 경우는 님이 말한 국연이나 건보에서 직접 운영하는 대외활동 우수활동자로 수료하면 지원할때 가산점 주는 기업은 꽤 있음 그거 노리셔요
        """,
        commentId: 14,
        writer : "익명1",
        createdAt : "2024-11-14 12:13:13"
      ),
    ],
  ];
}