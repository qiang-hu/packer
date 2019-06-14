# packer
packer定制系统镜像

==========
AWS
==========
1.生成AWS用户访问密钥
用户------>安全证书------>访问密钥
添加环境变量：
$ export AWS_ACCESS_KEY_ID="anaccesskey"
$ export AWS_SECRET_ACCESS_KEY="asecretkey"
$ export AWS_DEFAULT_REGION="us-west-2"
或者直接在模板文件中定义
{
    "access_key": "xxxxxxxxxxxxxxx",
    "secret_key": "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx",
    "region": "us-east-1",
    "type": "amazon-ebs"
}

2.创建AWS默认VPC、子网（新账号默认存在，如果删除了使用如下命令重新创建）
$ aws ec2 create-default-vpc
$ aws ec2 create-default-subnet --availability-zone ap-southeast-1a  (指定可用区)

3.检查语法和配置值是否有效
$ packer validate template.json

4.构建image
$ packer build \
    -var 'aws_access_key=YOUR ACCESS KEY' \
    -var 'aws_secret_key=YOUR SECRET KEY' \
    example.json
