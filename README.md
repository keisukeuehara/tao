# tao
Dockerfile for tao testing

# taoをスタート 

```
$ docker build -t tao .
$ docker run -d --name tao -p 80:80 tao
```

# Docker初心者のためのメモ

```
> $ docker build -t tao .                   # docker imageを作る
> $ docker run -d --name tao -p 80:80 tao   # docker containerを走らせる
> $ docker images                           # docker imageを確認する
> $ docker rmi 2f37bab81128                 # docker imageを削除する
> $ docker stop tao                         # docker containerを止める
> $ docker start tao                        # docker containerを開始する
> $ docker exec -it tao bash                # docker containerにログインする
> $ docker ps -a                            # docker containerを確認する
> $ docker rm tao                           # docker containerを削除する
```
