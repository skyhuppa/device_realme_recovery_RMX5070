## TWRP DEVICE TREE FOR REALME P3 5G (RMX5070)

#### build completed successfully 

Specific | Info
--------:|:-------------------------
product board | volcano
product release name | RMX5070

NOTE: for this branch build for target "recoveryimage" because actual kernel image is in stock boot partition and dtb image is in vendor-boot partition. I focused on the stock recovery image which has the ramdisk files needed to boot from twrp. If anyone want to build for target vendorbootimage because cmdline is in vendor-boot then enable vendor_boot blobs in boardconfig.mk

## Credit 
TWRP TEAM, 
Arunpain
