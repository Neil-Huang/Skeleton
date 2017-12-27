@echo on
@echo =============================================================
@echo $                                                           $
@echo $                      Nepxion Skeleton                     $
@echo $                                                           $
@echo $                                                           $
@echo $                                                           $
@echo $  Nepxion Technologies All Right Reserved                  $
@echo $  Copyright(C) 2017                                        $
@echo $                                                           $
@echo =============================================================
@echo.
@echo off

@title Nepxion Skeleton
@color 0a

@set PROJECT_NAME=skeleton-spring-cloud
@set PROJECT_LIST=skeleton-engine,%PROJECT_NAME%

set DOCKER_HOST=tcp://localhost:2375
@rem set DOCKER_CERT_PATH=C:\Users\Neptune\.docker\machine\certs
@set IMAGE_NAME=skeleton-spring-cloud
@set MACHINE_PORT=2222
@set CONTAINER_PORT=2222

if exist %PROJECT_NAME%\target rmdir /s/q %PROJECT_NAME%\target

@rem 执行相关模块的Maven Install
call mvn clean install -DskipTests -pl %PROJECT_LIST% -am

@rem 停止和删除Docker容器
call docker stop %IMAGE_NAME%
@rem call docker kill %IMAGE_NAME%
call docker rm %IMAGE_NAME%

@rem 删除Docker镜像
call docker rmi %IMAGE_NAME%

cd %PROJECT_NAME%

@rem 安装Docker镜像
call mvn package docker:build -DskipTests

@rem 安装和启动Docker容器，并自动执行端口映射
call docker run -i -t -p %MACHINE_PORT%:%CONTAINER_PORT% --name %IMAGE_NAME% %IMAGE_NAME%:latest

pause