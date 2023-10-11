## Team : 화양연화

팀장 이준석 : [junnn0021](https://github.com/junnn0021) | 이준석 : [junnn0021](https://github.com/junnn0021) | 이준석 : [junnn0021](https://github.com/junnn0021) | 이준석 : [junnn0021](https://github.com/junnn0021) | 
 --- | --- | --- | --- |

- **우리가 함께 성장해가는 이 순간은 인생에서 가장 빛나는 행복한 시간이다.**
- Team Notion : [花様年華](https://www.notion.so/da73182e65984c3b8a985bc8ce32e699)
- Duration : 2023.08.28~23.09.01
<br>

## Requirement

### Web Server / WAS 서비스를 위한 인프라 구축

- Web Server 구축(apache v2.4 ~)
- WAS 구축(tomcat) - java: OpenJDK 설치 & yum/dnf로 java 설치 선택
- Web Server-WAS 연동 - Proxy모드 설정 또는 mod.jk 모드 설정
- DB 구축 및 연동
- CDN, 애플리케이션 및 인프라 모니터링, DNS 구성<p>
　　　　　　　　　+
- 기존 3 Tier로 구축한 위 과정을 Docker, K8s로 구축
<br>

## Summary
우리 페이지는 **도서 구매 예약 시스템**을 운영합니다.<p>사용자는 페이지 접속 후, 사용자 정보와 구매할 도서 정보를 입력하게 됩니다.<p>서버는 **Docker image를 이용하여 K8s를 구축**했습니다.<p>데이터베이스는 **GCP를 이용하여 구축**했습니다.<p>(현 프로젝트는 제공받은 Petclinic 코드를 일부 수정하여 진행했습니다.)

<br>

## User Flow
![image](https://github.com/junnn0021/book-reservation/assets/119108967/d665cb98-ed5d-4883-b7ab-16f719fbde96)

<br>

## Architecture

![image](https://github.com/junnn0021/book-reservation-k8s/assets/119108967/ff699c5b-d883-4641-861c-37392320b74a)
- 아키텍처 구현 과정 : [Notion](https://www.notion.so/Project_Docker-K8s-df3fec7282fb4ad2883eaececfec8687)

<br>

## Environment
<!--<div align=center>-->
<img src="https://img.shields.io/badge/GCP-4285F4?stylefor-the-badge&logo=Google Cloud&logoColor=FAFAFA"/> <img src="https://img.shields.io/badge/Apache-D22128?stylefor-the-badge&logo=Apache&logoColor=FAFAFA"/>
<img src="https://img.shields.io/badge/Tomcat-F8DC75?stylefor-the-badge&logo=Apache Tomcat&logoColor=000000"/>
<img src="https://img.shields.io/badge/Maven-C71A36?stylefor-the-badge&logo=Apache Maven&logoColor=FAFAFA"/>
<img src="https://img.shields.io/badge/JMeter-D22128?stylefor-the-badge&logo=Apache JMeter&logoColor=FAFAFA"/>

<!--</div>-->

<br>

## Example of use


<br>

## Prerequisites

아래 주어진 과정을 실행해야 합니다.

<br>

## Spring PetClinic Sample Application

### Tomcat 설치 및 Start
Tomcat 설치 가이드를 참조하여 Tomcat 설치 후, tomcat-users.xml 에 User 및 Role 추가합니다.

[ Ubuntu 18.04 : Tomcat 9 설치하는 방법 ](https://jjeongil.tistory.com/1351)

Tomcat User 및 Role 추가

```
# $TOMCAT_HOME/conf/tomcat-users.xml 파일에 아래 행들을 추가

    <role rolename="manager-script"/>
    <role rolename="manager-gui"/>
    <role rolename="manager-jmx"/>
    <role rolename="manager-status"/>
    <user username="tomcat" password="tomcat" roles="manager-gui,manager-script,manager-status,manager-jmx"/>
```

Tomcat 을 실행 ( 위의 Tomcat 설치 가이드를 통해서 이미 실행되어 있는 경우에는 Skip )

```
$TOMCAT_HOME/bin/catalina.sh start
```

### Tomcat 배포 ( H2 In-memory Database 활용 )
```
git clone https://github.com/SteveKimbespin/petclinic_btc.git 
cd petclinic_btc
./mvnw tomcat7:deploy
```

### 외부에 구성한 MySQL Database 연결 방법

MySQL 을 각 CSP 의 DB Service 로 구성
  - database 명 : petclinic  
  - db user 및 password 설정

MySQL database 접속 설정을 하기 위해, pom.xml 파일에 정의 된 'MySQL' profile 을 아래와 같이 수정후, 재배포(redeploy)한다.
  - jdbc.url 부분에 정의되어 있는 DNS 또는 IP Address 를 연결하고자 하는 MySQL IP 로 변경한다. ( 필요시 database 도 수정)
  - db 접속 User ID 및 Password 수정

```
<properties>
    <jpa.database>MYSQL</jpa.database>
    <jdbc.driverClassName>com.mysql.cj.jdbc.Driver</jdbc.driverClassName>
    <jdbc.url>jdbc:mysql://localhost:3306/petclinic?useUnicode=true</jdbc.url>
    <jdbc.username>petclinic</jdbc.username>
    <jdbc.password>petclinic</jdbc.password>
</properties>
```      

Tomcat 에 재배포

```
# 기존에 배포되어 있는 환경에 MySQL 연결 설정 수정후, 재배포 하는 경우
./mvnw tomcat7:redeploy -P MySQL

# 최초 배포하는 경우
./mvnw tomcat7:deploy -P MySQL
```
