Terraform module which create image on Alibaba Cloud.  
terraform-alicloud-ecs-image
=============================================

English | [简体中文](https://github.com/terraform-alicloud-modules/terraform-alicloud-ecs-image/blob/master/README-CN.md)

Terraform module which create image by instance_id or snapshot_id on Alibaba Cloud and copy image and share image.

These types of resources are supported:

* [Image](https://www.terraform.io/docs/providers/alicloud/r/image.html)
* [Image_copy](https://www.terraform.io/docs/providers/alicloud/r/image_copy.html)
* [Image_export](https://www.terraform.io/docs/providers/alicloud/r/image_export.html)
* [Image_import](https://www.terraform.io/docs/providers/alicloud/r/image_import.html)
* [Image_share_permission](https://www.terraform.io/docs/providers/alicloud/r/image_share_permission.html)

## Terraform versions

The Module requires Terraform 0.12 and Terraform Provider AliCloud 1.69.0+.

## Usage

Create a image by instance_id.

```hcl
module "image_create" {
  source      = "terraform-alicloud-modules/ecs-image/alicloud"
  instance_id = "i-uf6etbb1qr3hri95****"
}
```

Create a image by instance_id.

```hcl
module "image_create" {
  source      = "terraform-alicloud-modules/ecs-image/alicloud"
  snapshot_id = "s-uf6bdgo6775mf8k*****"
}
```

Create a image by combined disk.

```hcl
module "image_create" {
  source      = "terraform-alicloud-modules/ecs-image/alicloud"
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

Create a image by instance_id and share the image and export the image to oss_bucket.

```hcl
module "image_create" {
  source            = "terraform-alicloud-modules/ecs-image/alicloud"
  snapshot_id       = "s-uf6bdgo6775mf8k7****"
  share             = true
  account_ids       = ["123456789012****"]
  export            = true
  export_oss_bucket = "iamge-bucket"
}
```

Export the image by image_id.

```hcl
module "image_export" {
  source            = "terraform-alicloud-modules/ecs-image/alicloud"
  export            = true
  image_id          = ["m-uf6gkgbv29y10478****"]
  export_oss_bucket = "iamge-bucket"
}
```

Import image form oss_bucket.

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

## Modules

This Module provides templates for coping image and sharing image.

* [Image-copy](https://github.com/terraform-alicloud-modules/terraform-alicloud-ecs-image/tree/master/modules/image-copy)
* [Image-share-permission](https://github.com/terraform-alicloud-modules/terraform-alicloud-ecs-image/tree/master/modules/image-share-permission)


## Examples

* [Image-create](https://github.com/terraform-alicloud-modules/terraform-alicloud-ecs-image/tree/master/examples/image-create)
* [Image-copy](https://github.com/terraform-alicloud-modules/terraform-alicloud-ecs-image/tree/master/examples/image-copy)
* [Image-share-permission](https://github.com/terraform-alicloud-modules/terraform-alicloud-ecs-image/tree/master/examples/image-share-permission)


## Notes
* This module using AccessKey and SecretKey are from `profile` and `shared_credentials_file`.
If you have not set them yet, please install [aliyun-cli](https://github.com/aliyun/aliyun-cli#installation) and configure it.

Submit Issues
-------------
If you have any problems when using this module, please opening a [provider issue](https://github.com/terraform-providers/terraform-provider-alicloud/issues/new) and let us know.

**Note:** There does not recommend to open an issue on this repo.

Authors
-------
Created and maintained by Zhou qilin(z17810666992@163.com), He Guimin(@xiaozhu36, heguimin36@163.com).

License
----
Apache 2 Licensed. See LICENSE for full details.

Reference
---------
* [Terraform-Provider-Alicloud Github](https://github.com/terraform-providers/terraform-provider-alicloud)
* [Terraform-Provider-Alicloud Release](https://releases.hashicorp.com/terraform-provider-alicloud/)
* [Terraform-Provider-Alicloud Docs](https://www.terraform.io/docs/providers/alicloud/index.html)
