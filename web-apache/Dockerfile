# 베이스 이미지로 Ubuntu 사용
FROM ubuntu:latest

# 필요한 패키지 설치 및 Apache2 설치
RUN apt-get update && apt-get install -y apache2

# 000-default.conf 파일 복사
COPY ./000-default.conf /etc/apache2/sites-available/

# 필요한 모듈 활성화 및 Apache2 시작
RUN a2enmod proxy && a2enmod proxy_http && service apache2 restart

# Apache2 실행
CMD ["apache2ctl", "-D", "FOREGROUND"]