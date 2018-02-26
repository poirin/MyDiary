# MyDiary [![Build Status](https://travis-ci.org/poirin/MyDiary.svg?branch=master)](https://travis-ci.org/poirin/MyDiary.svg?branch=master) [![License: GPL v3](https://img.shields.io/badge/License-GPL%20v3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0)

My Diary is a web service that helps users manage their portfolio. Users can record, store and manage their various activities (competition, projects, service activities, etc..). The server generates a portfolio (PPT) based on activities and helps users to automatically create their own portfolios with the desired design. Also users can edit and make their own design of portfolio.

*Website : http://poirin.cafe24.com/

# How To Start

1. ```$ git clone https://github.com/poirin/MyDiary```

2. Excute MySQL and type as follows to create database and tables.
```
mysql> create database bbs;
mysql> use bbs;
mysql> CREATE TABLE user (userID varchar(20) NOT NULL, userPW varchar(20) NOT NULL, 
userEmail varchar(40) NOT NULL, actNumber int(11) NOT NULL, PRIMARY KEY (userID));
mysql> CREATE TABLE activity (userID varchar(20) NOT NULL, actNum int(11) NOT NULL, 
actType varchar(50) NOT NULL, actName varchar(50) NOT NULL, startDate date DEFAULT NULL, 
endDate date DEFAULT NULL, actSummary varchar(100) DEFAULT NULL, actContent varchar(2000) DEFAULT NULL, 
actResult varchar(2000) DEFAULT NULL, actStatus varchar(30) DEFAULT NULL, PRIMARY KEY (userID,actNum));
```

3. Modify string variable dbID and dbPassword to your mysql id/password in code <a href = "https://github.com/poirin/MyDiary/blob/master/src/htmlcreate/HTMLCreateDAO.java">HTMLCreateDAO.java</a>, <a href = "https://github.com/poirin/MyDiary/blob/master/src/pptcreate/PPTCreateDAO.java">PPTCreateDAO.java</a>, <a href = "https://github.com/poirin/MyDiary/blob/master/src/user/UserDAO.java">UserDAO.java</a> and <a href = "https://github.com/poirin/MyDiary/blob/master/src/activity/ActivityDAO.java">ActivityDAO.java</a>

4. ```$ mvn install```

# Features
- <a href="https://github.com/poirin/doc/blob/master/mydiary/activityadddelete.gif">Add/Remove activity</a><br>
![AddRemove](https://github.com/poirin/doc/blob/master/mydiary/activityadddelete.gif)

- <a href="https://github.com/poirin/doc/blob/master/mydiary/activitymodify.gif">Modify activity</a><br>
![Modify](https://github.com/poirin/doc/blob/master/mydiary/activitymodify.gif)

- <a href="https://github.com/poirin/doc/blob/master/mydiary/activitysearch.gif">Search activity</a><br>
![Search](https://github.com/poirin/doc/blob/master/mydiary/activitysearch.gif)

- <a href="https://github.com/poirin/doc/blob/master/mydiary/ppt.gif">Select template PPT design / Export portfolio</a><br>
![PPT](https://github.com/poirin/doc/blob/master/mydiary/ppt.gif)

- <a href="https://github.com/poirin/doc/blob/master/mydiary/pdf.gif">Edit and Export portfolio(PDF)</a><br>
![PDF](https://github.com/poirin/doc/blob/master/mydiary/pdf.gif)

- See activity list at a glance<br>

# Third party libraries
- <a href = https://github.com/apache/poi>Apache POI</a><br>
- <a href = https://github.com/artf/grapesjs>grape.js</a><br>
- <a href = https://github.com/niklasvh/html2canvas>html2canvas</a><br>
- <a href = https://github.com/twbs/bootstrap>bootstrap</a><br>
- <a href = https://github.com/jquery/jquery>jquery</a><br>
- <a href = https://github.com/MrRio/jsPDF>jspdf</a><br>

# Todo
- Provide various portfolio type
- Add recommending PPT design template

# Founders
- Kang Byeonggoo, <a href="kbg31tk@gmail.com">kbg31tk@gmail.com</a>, <a href="https://github.com/kbg2875">https://github.com/kbg2875</a><br>
- Kim Hyeongmin, <a href="poirin@naver.com">poirin@naver.com</a>, <a href="https://github.com/poirin">https://github.com/poirin</a>

# Code of conduct
<a href = "https://github.com/poirin/MyDiary/blob/master/CODE_OF_CONDUCT.md">CODE_OF_CONDUCT</a>

# LICENSE
GNU GENERAL PUBLIC LICENSE v3.0
