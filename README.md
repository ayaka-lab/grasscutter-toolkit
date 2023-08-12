# grasscutter-docker
grasscutter的docker版本，快速启动游戏服务器

### 操作模式

1. 安装Docker，DockerCompose

2. 安装Git，如果安装了可以跳过

```bash
sudo apt-get update
sudo apt-get -y install git
```

3. 克隆本仓库
```bash
git clone https://github.com/ayaka-lab/grasscutter-toolkit && cd grasscutter-toolkit
```

4. 仔细看清楚你需要的游戏版本，修改docker-compose文件里面的`:latest`为对应的版本，具体可以去看https://hub.docker.com/repository/docker/ayakalab/grasscutter/general的里面的tag。
目前支持的tag有：
- 3.5
- 3.6

然后，把你的网站的p12证书，放在config/grasscutter里面，最后检查config.json文件即可。

5. 启动服务器
```bash
docker-compose up -d
```