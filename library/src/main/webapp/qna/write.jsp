<%@ page contentType="text/html; charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>글쓰기</title>
</head>
<body>

<h2>새 글 작성하기</h2>

<form action="writeProcess.jsp" method="post">
    <label for="category">카테고리</label>
<select name="category" id="category">
    <option value="일반">일반</option>
    <option value="질문">질문</option>
    <option value="건의">건의</option>
</select><br><br>
    
    작성자 이름: <input type="text" name="writer" required><br><br>
    
    제목: <input type="text" name="title" required><br><br>
    

    
    내용: <textarea name="content" rows="7" cols="60" required></textarea><br><br>
    
    공개 여부: 
    <select name="openYn">
        <option value="Y">공개</option>
        <option value="N">비공개</option>
    </select><br><br>
    
    비밀번호 (글 수정/삭제용): <input type="password" name="password" required><br><br>
    
    <button type="submit">글쓰기</button>
</form>

</body>
</html>
