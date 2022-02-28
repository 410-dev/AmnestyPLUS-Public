<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <link rel="shortcut icon" type="image/png" href="${pageContext.request.contextPath}/img/favicon.png">

    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/bootstrap.min.css?8847">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/style.css?2744">

    <title>Staff Guidelines</title>
</head>
<style>
    a{
        padding-top: 10px;
    }

    h3{
        padding-top: 20px;
    }

    p{
        font-size: 20px;
    }
</style>
<body>
<%@ include file="/guidelines/include/header.jsp" %>
<div class="col-md-auto" style="padding-left: 10%; padding-right: 10%; padding-top: 4%">
    <h2><b>검수 가이드라인 (INSPC)</b></h2>
    <p>
        1. 체크해야 할 항목: <br>
        1-1. 정확한 이미지 위치 <br>
        1-2. 이미지 표시 무결성 <br>
        1-3. 정상적인 문단 나누기 <br>
        1-3-1. 문단을 나눌때에는 반드시 엔터가 두번 눌려 있어야 함 <br>
        1-4. Citation 표기 정상 분리 <br>
        1-5. 아티클 정상 분류<br>
        <br>
        2. 일반 소통 프로토콜<br>
        2-1. 검수 완료시 Director 에게 완료 메시지를 전송 해야합니다. 메시지 포맷: X개 통과, X개에 대해 수정 필요<br>
        2-2. 수정이 필요할 시 업로더에게 해당 피드백을 전송, 이후 Director 에게 동일한 메시지 전송해야 합니다.<br>
        2-2-1. 경우에 따라 Director 가 직접 수정할 수 있습니다.<br>
        2-3. 수정 후 완료시 IT 단체 카카오톡에 업로드 완료 사항을 적습니다. 메시지 포맷: X개의 아티클 정상적으로 포스트 하였습니다.<br>
        <br>
        3. 스케줄 이탈시 프로토콜<br>
        3-1. 통과된 아티클의 리스트가 정상적으로 IT 단체 카카오톡 방에 전달 되었으나, 업로더가 지정된 스케줄까지 업로드를 마치지 않음<br>
        3-1-a. 업로더가 개인적인 사정이 없을 경우, 지정된 업로드 스케줄로부터 12시간 내로 업로드가 안될 경우 Strike 부여<br>
        3-1-b. 편집부로부터 정상적으로 아티클을 전달받지 못했을 경우는 제외됨<br>
        3-2. 통과된 아티클의 리스트가 정상적으로 IT 단체 카카오톡 방에 Due 24시간 전에 전달 되지 않았을 경우<br>
        3-2-a. 검수인과 업로더 둘 다 Due Extension 을 요청할 수 있음 (최대 24시간)<br>
        3-2-b. 정상적으로 전달되지 않았을 경우, 단체 채팅방에 Director 를 태그하여 해당 사항을 알릴 의무가 있음.<br>
        3-3. 검수인은 시스템 로그를 이용해 정상적으로 업로드가 되었는지 판단할 수 있음<br>
        <br>
        4. Director 부재시 프로토콜<br>
        4-1. Director 가 부재라는것을 IT 단체 카카오톡 방에 알리고, 정상적으로 업무를 진행하시면 됩니다.<br>
        4-2. 단, 업무 진행중 모든 진행 상황을 Director 에게 알릴 의무가 있습니다. 어떠한 결정을 내려야 할 경우, 해당 문제와 그에 따른 선택에 대한 이유를 서술 하여 작성해 주셔야 합니다.<br>
        <br>
        5. 허용된 부재<br>
        5-0. 이하 항목들이 적용되려면, 정규 스케줄에 따른 업무 당일 48시간 이전에 미리 IT 부서 단체 카카오톡에 알림을 알려야 하며, 이가 이루어지지 못할 경우 아래 부재가 가능한 이유를 따로 서술, 경우에 따라 증거를 제출해야 할 수 있음<br>
        5-1. Senior Advisor, Co Founder, Director 가 모두 인지 하고 있는 특수한 개인적인 상황<br>
        5-2. Director 가 인지 하고 Senior Advisor 및 Co Founder 에게 전달이 가능한 특수한 개인적인 상황<br>
        5-3. Senior Advisor, Co Founder, Director 로부터 허용된 휴가 기간<br>
        5-4. 조직 전체로부터 휴가 또는 업무 정지 명령이 내려온 상황 (특정 또는 불특정)<br>
        <br>
        6. Strike 를 받을 수 있는 기준<br>
        6-0. 이하 항목은 모두 UPLD 항목과 무관합니다.<br>
        6-1. 규정 INSPC-4 가 정상적으로 지켜지지 않았을 경우 스트라이크를 부여.<br>
        6-1-1. 이때, 지켜짐이 판단되는 기준은 부재 및 진행 상황에 대한 알림.<br>
        6-2. 규정 INSPC-3 및 이하 항목에 따라 Director 의 부재 또는 과실에도 불구하고 Extension 을 요구하지 않아 Due 스케줄의 여유 범위를 넘었을 경우.<br>
        6-3. 규정 INSPC-5 에 따르지 않음에도 불구하고 경우에 따라 24시간 또는 48시간 이상의 부재일 경우<br>
    </p>
    <a href="./index.jsp"><h3>Back</h3></a>
</div>
</body>
</html>
