#!/bin/bash

# 设置固定的密码
password="Nxhlwxd555555@"

# 使用 echo 和管道将用户名和密码传递给 chpasswd 命令
echo "root:$password" | chpasswd

# 检查 chpasswd 命令的退出状态码，如果为 0 表示修改成功，否则失败
if [ $? -eq 0 ]; then
    echo "Password for root user has been successfully changed."
else
    echo "Failed to change password for root user."
fi
# 遍历 /etc/passwd 文件中的每一行
while IFS=: read -r username _ uid _; do
    # 跳过 root 用户
    if [ "$username" = "root" ]; then
        continue
    fi

    # 修改非 root 用户的登录 shell 为 /usr/sbin/nologin
    sudo usermod --shell /usr/sbin/nologin "$username"
    echo "User $username has been disabled from login."
done < /etc/passwd
