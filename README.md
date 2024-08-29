Terraform module which create image on Alibaba Cloud.  
terraform-alicloud-ecs-image


English | [简体中文](https://github.com/terraform-alicloud-modules/terraform-alicloud-ecs-image/blob/master/README-CN.md)

Terraform module which create image by instance_id or snapshot_id on Alibaba Cloud and copy image and share image.

These types of resources are supported:

* [Image](https://www.terraform.io/docs/providers/alicloud/r/image.html)
* [Image_copy](https://www.terraform.io/docs/providers/alicloud/r/image_copy.html)
* [Image_export](https://www.terraform.io/docs/providers/alicloud/r/image_export.html)
* [Image_import](https://www.terraform.io/docs/providers/alicloud/r/image_import.html)
* [Image_share_permission](https://www.terraform.io/docs/providers/alicloud/r/image_share_permission.html)

## Usage

Create a image by instance_id.

```hcl
module "image_create" {
  source      = "terraform-alicloud-modules/ecs-image/alicloud"

  create      = true
  instance_id = "i-uf6etbb1qr3hri95****"
}
```

Create a image by snapshot_id.

```hcl
module "image_create" {
  source      = "terraform-alicloud-modules/ecs-image/alicloud"

  create      = true
  snapshot_id = "s-uf6bdgo6775mf8k*****"
}
```

Create a image by combined disk.

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

Create a image by instance_id and share the image and export the image to oss_bucket.

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

* [Complete Example](https://github.com/terraform-alicloud-modules/terraform-alicloud-ecs-image/tree/master/examples/complete)

## Notes
From the version v1.2.0, the module has removed the following `provider` setting:

```hcl
provider "alicloud" {
  profile                 = var.profile != "" ? var.profile : null
  shared_credentials_file = var.shared_credentials_file != "" ? var.shared_credentials_file : null
  region                  = var.region != "" ? var.region : null
  skip_region_validation  = var.skip_region_validation
  configuration_source    = "terraform-alicloud-modules/ecs-image"
}
```

If you still want to use the `provider` setting to apply this module, you can specify a supported version, like 1.1.0:

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

If you want to upgrade the module to 1.2.0 or higher in-place, you can define a provider which same region with
previous region:

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
or specify an alias provider with a defined region to the module using `providers`:

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

and then run `terraform init` and `terraform apply` to make the defined provider effect to the existing module state.

More details see [How to use provider in the module](https://www.terraform.io/docs/language/modules/develop/providers.html#passing-providers-explicitly)

## Terraform versions

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13.0 |
| <a name="requirement_alicloud"></a> [alicloud](#requirement\_alicloud) | >= 1.69.0 |

Submit Issues
-------------
If you have any problems when using this module, please opening a [provider issue](https://github.com/terraform-providers/terraform-provider-alicloud/issues/new) and let us know.

**Note:** There does not recommend to open an issue on this repo.

Authors
-------
Created and maintained by Alibaba Cloud Terraform Team(terraform@alibabacloud.com)

License
----
Apache 2 Licensed. See LICENSE for full details.

Reference
---------
* [Terraform-Provider-Alicloud Github](https://github.com/terraform-providers/terraform-provider-alicloud)
* [Terraform-Provider-Alicloud Release](https://releases.hashicorp.com/terraform-provider-alicloud/)
* [Terraform-Provider-Alicloud Docs](https://www.terraform.io/docs/providers/alicloud/index.html)