locals {
  # Values for the optional components
  org        = var.org != null ? "${var.org}${var.separator}" : ""
  descriptor = var.descriptor != null ? "${var.descriptor}${var.separator}" : ""
  index      = var.index != null ? "${var.index}${var.separator}" : ""
  env        = var.env != null ? "${var.env}${var.separator}" : ""
  region     = var.region != null ? "${var.region}${var.separator}" : ""
  zone       = var.zone != null ? "${var.zone}${var.separator}" : ""

  # Values for the required components
  app = "${var.app}${var.separator}"

  # Selecting the region or zone based on availability.
  # Also, no separator is added for region or zone. As this is the last component.
  region_zone = var.zone != null ? "${var.zone}" : "${var.region}"

  # Constructing the full resource name template. %s is the placeholder for the resource type short name.
  resource_name_template = "${local.org}${local.app}${local.descriptor}%s-${local.index}${local.env}${local.region_zone}"
}
