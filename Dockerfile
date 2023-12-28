FROM openjdk:8
EXPOSE 9095
ADD target/java-pdo.jar java-pdo.jar
ENTRYPOINT ["java","-jar","/java-pdo.jar"]
