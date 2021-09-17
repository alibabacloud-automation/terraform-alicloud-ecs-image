terraform-alicloud-ecs-image
============================

Terraform模块用于在阿里云上通过 ECS 实例 ID 或者快照 ID 创建镜像，支持镜像的复制和分享。

支持以下类型的资源：

* [Image](https://www.terraform.io/docs/providers/alicloud/r/image.html)
* [Image_copy](https://www.terraform.io/docs/providers/alicloud/r/image_copy.html)
* [Image_export](https://www.terraform.io/docs/providers/alicloud/r/image_export.html)
* [Image_import](https://www.terraform.io/docs/providers/alicloud/r/image_import.html)
* [Image_share_permission](https://www.terraform.io/docs/providers/alicloud/r/image_share_permission.html)

## Terraform 版本

本 Module 要求使用 Terraform 0.12 和 阿里云 Provider 1.69.0+。

## 用法

通过 ECS 实例 ID 创建镜像。

```hcl
module "image_create" {
  source      = "terraform-alicloud-modules/ecs-image/alicloud"
  region      = "cn-shanghai"
  profile     = "Your-Profile-Name"

  create      = true
  instance_id = "i-uf6etbb1qr3hri95****"
}
```

通过多份快照组合成创建映像。

```hcl
module "image_create" {
  source      = "terraform-alicloud-modules/ecs-image/alicloud"
  region      = "cn-shanghai"
  profile     = "Your-Profile-Name"

  create      = true
  disk_device_mapping = [
    {
      device      = "/dev/xvda"
      size        = 10
      disk_type   = "system"
      snapshot_id = "s-uf6bdgo6775mf8k7****"
    },
    {
      size      = 5
      disk_type = "data"
    }
  ]
}
```

通过快照 ID 创建镜像。

```hcl
module "image_create" {
  source      = "terraform-alicloud-modules/ecs-image/alicloud"
  region      = "cn-shanghai"
  profile     = "Your-Profile-Name"

  create      = true
  snapshot_id = "s-uf6bdgo6775mf8k*****"
}
```

通过快照 ID 创建镜像并分享给其他阿里云账户和导出到 oss_bucket 中。

```hcl
module "image_create" {
  source            = "terraform-alicloud-modules/ecs-image/alicloud"
  region            = "cn-shanghai"
  profile           = "Your-Profile-Name"

  create            = true
  snapshot_id       = "s-uf6bdgo6775mf8k7****"
  share             = true
  account_ids       = ["123456789012****"]
  export            = true
  export_oss_bucket = "iamge-bucket"
}
```

通过镜像 ID 将镜像导出到 oss_bucket 中。

```hcl
module "image_export" {
  source            = "terraform-alicloud-modules/ecs-image/alicloud"
  region            = "cn-shanghai"
  profile           = "Your-Profile-Name"

  export            = true
  image_id          = ["m-uf6gkgbv29y104788x97"]
  export_oss_bucket = "iamge-bucket"
}
```

将 oss_bucket 中的镜像导出到本地镜像（不支持压缩类型镜像）。

```hcl
module "image_import" {
  source            = "terraform-alicloud-modules/ecs-image/alicloud"
  region            = "cn-shanghai"
  profile           = "Your-Profile-Name"

  import            = true
  import_image_name = "tf-001"
  import_disk_device_mapping = {
    import_oss_bucket = "iamge-bucket"
    oss_object        = "tf_m-uf6gkgbv29y104788x97xxxxxx"
  }
}
```

## 模板

本 Module 提供了对镜像的复制及分享。

* [镜像复制模板](https://github.com/terraform-alicloud-modules/terraform-alicloud-ecs-image/tree/master/modules/image-copy)
* [镜像分享模板](https://github.com/terraform-alicloud-modules/terraform-alicloud-ecs-image/tree/master/modules/image-share-permission)


## 示例

* [镜像创建示例](https://github.com/terraform-alicloud-modules/terraform-alicloud-ecs-image/tree/master/examples/image-create)
* [镜像复制示例](https://github.com/terraform-alicloud-modules/terraform-alicloud-ecs-image/tree/master/examples/image-copy)
* [镜像分享示例](https://github.com/terraform-alicloud-modules/terraform-alicloud-ecs-image/tree/master/examples/image-share-permission)


## 注意事项

* 本 Module 使用的 AccessKey 和 SecretKey 可以直接从 `profile` 和 `shared_credentials_file` 中获取。如果未设置，可通过下载安装 [aliyun-cli](https://github.com/aliyun/aliyun-cli#installation) 后进行配置。

提交问题
-------
如果在使用该 Terraform Module 的过程中有任何问题，可以直接创建一个 [Provider Issue](https://github.com/terraform-providers/terraform-provider-alicloud/issues/new)，我们将根据问题描述提供解决方案。

**注意:** 不建议在该 Module 仓库中直接提交 Issue。

作者
-------
Created and maintained by Alibaba Cloud Terraform Team(terraform@alibabacloud.com).

参考
----
Apache 2 Licensed. See LICENSE for full details.

许可
---------
* [Terraform-Provider-Alicloud Github](https://github.com/terraform-providers/terraform-provider-alicloud)
* [Terraform-Provider-Alicloud Release](https://releases.hashicorp.com/terraform-provider-alicloud/)
* [Terraform-Provider-Alicloud Docs](https://www.terraform.io/docs/providers/alicloud/index.html)
