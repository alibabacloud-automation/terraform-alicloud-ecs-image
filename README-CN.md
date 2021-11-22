terraform-alicloud-ecs-image
============================

Terraform模块用于在阿里云上通过 ECS 实例 ID 或者快照 ID 创建镜像，支持镜像的复制和分享。

支持以下类型的资源：

* [Image](https://www.terraform.io/docs/providers/alicloud/r/image.html)
* [Image_copy](https://www.terraform.io/docs/providers/alicloud/r/image_copy.html)
* [Image_export](https://www.terraform.io/docs/providers/alicloud/r/image_export.html)
* [Image_import](https://www.terraform.io/docs/providers/alicloud/r/image_import.html)
* [Image_share_permission](https://www.terraform.io/docs/providers/alicloud/r/image_share_permission.html)

## 用法

通过 ECS 实例 ID 创建镜像。

```hcl
module "image_create" {
  source      = "terraform-alicloud-modules/ecs-image/alicloud"

  create      = true
  instance_id = "i-uf6etbb1qr3hri95****"
}
```

通过多份快照组合成创建映像。

```hcl
module "image_create" {
  source      = "terraform-alicloud-modules/ecs-image/alicloud"

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

  create      = true
  snapshot_id = "s-uf6bdgo6775mf8k*****"
}
```

通过快照 ID 创建镜像并分享给其他阿里云账户和导出到 oss_bucket 中。

```hcl
module "image_create" {
  source            = "terraform-alicloud-modules/ecs-image/alicloud"

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

  export            = true
  image_id          = ["m-uf6gkgbv29y104788x97"]
  export_oss_bucket = "iamge-bucket"
}
```

将 oss_bucket 中的镜像导出到本地镜像（不支持压缩类型镜像）。

```hcl
module "image_import" {
  source            = "terraform-alicloud-modules/ecs-image/alicloud"

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
本Module从版本v1.2.0开始已经移除掉如下的 provider 的显示设置：

```hcl
provider "alicloud" {
  profile                 = var.profile != "" ? var.profile : null
  shared_credentials_file = var.shared_credentials_file != "" ? var.shared_credentials_file : null
  region                  = var.region != "" ? var.region : null
  skip_region_validation  = var.skip_region_validation
  configuration_source    = "terraform-alicloud-modules/ecs-image"
}
```

如果你依然想在Module中使用这个 provider 配置，你可以在调用Module的时候，指定一个特定的版本，比如 1.1.0:

```hcl
module "image_create" {
  source  = "terraform-alicloud-modules/ecs-image/alicloud"
  version = "1.1.0"
  region  = "cn-shanghai"
  profile = "Your-Profile-Name"
  create  = true
  // ...
}
```

如果你想对正在使用中的Module升级到 1.2.0 或者更高的版本，那么你可以在模板中显示定义一个系统过Region的provider：
```hcl
provider "alicloud" {
  region  = "cn-shanghai"
  profile = "Your-Profile-Name"
}
module "image_create" {
  source  = "terraform-alicloud-modules/ecs-image/alicloud"
  create  = true
  // ...
}
```
或者，如果你是多Region部署，你可以利用 `alias` 定义多个 provider，并在Module中显示指定这个provider：

```hcl
provider "alicloud" {
  region  = "cn-shanghai"
  profile = "Your-Profile-Name"
  alias   = "sh"
}
module "image_create" {
  source    = "terraform-alicloud-modules/ecs-image/alicloud"
  providers = {
    alicloud = alicloud.sh
  }
  create    = true
  // ...
}
```

定义完provider之后，运行命令 `terraform init` 和 `terraform apply` 来让这个provider生效即可。

更多provider的使用细节，请移步[How to use provider in the module](https://www.terraform.io/docs/language/modules/develop/providers.html#passing-providers-explicitly)

## Terraform 版本

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.12.0 |
| <a name="requirement_alicloud"></a> [alicloud](#requirement\_alicloud) | >= 1.69.0 |

提交问题
-------
如果在使用该 Terraform Module 的过程中有任何问题，可以直接创建一个 [Provider Issue](https://github.com/terraform-providers/terraform-provider-alicloud/issues/new)，我们将根据问题描述提供解决方案。

**注意:** 不建议在该 Module 仓库中直接提交 Issue。

作者
-------
Created and maintained by Alibaba Cloud Terraform Team(terraform@alibabacloud.com)

参考
----
Apache 2 Licensed. See LICENSE for full details.

许可
---------
* [Terraform-Provider-Alicloud Github](https://github.com/terraform-providers/terraform-provider-alicloud)
* [Terraform-Provider-Alicloud Release](https://releases.hashicorp.com/terraform-provider-alicloud/)
* [Terraform-Provider-Alicloud Docs](https://www.terraform.io/docs/providers/alicloud/index.html)
