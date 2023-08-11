# 使用方法：docker build -t ayakalab/grasscutter:latest .
# 基于Docker的官方镜像构建 https://hub.docker.com/_/gradle
FROM gradle:jdk17-jammy AS build

# 这个版本是3.5的，具体的可以参考
# https://github.com/Grasscutters/Grasscutter/releases
# 不同的Release有对应的版本
ARG gc_version=516e5975e1deead0ddbc87f5884ec58392870a53

# 资源文件对应的分支的名字，参考
# https://gitlab.com/Kamisato-Ayaka
ARG resources_version=3.5

# 指定工作目录
WORKDIR /app

# 克隆仓库的全部内容
RUN git clone https://github.com/Grasscutters/Grasscutter.git && cd Grasscutter && git checkout $gc_version

# 开始编译
RUN cd Grasscutter && chmod +x gradlew && ./gradlew jar

# 下载资源文件
RUN git clone -b $resources_version https://gitlab.com/Kamisato-Ayaka/GC-Resources.git ./Resources

# 使用 Java 17 的镜像作为基础镜像 
FROM docker.io/library/openjdk:17-jdk-slim

# 指定工作目录
WORKDIR /app

# 将 JAR 文件复制到容器中 
COPY --from=build /app/Grasscutter/*.jar grasscutters.jar
COPY --from=build /app/Resources/Resources resources

# 在容器中运行应用程序 
ENTRYPOINT ["java", "-jar", "grasscutters.jar"]
