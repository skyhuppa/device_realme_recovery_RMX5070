## TWRP DEVICE TREE FOR REALME P3 5G 


| Product Board        | volcano |
|                      |         |
| Product Release Name | RMX5070 |
|                      |         |
| Board Platform       | volcano |
|                      |         |

## Getting Started ##
To get started with AOSP sources to build TWRP, you'll need to get familiar
with [Git and Repo](https://source.android.com/source/using-repo.html).

To initialize your local repository using the AOSP trees to build TWRP, use a command like this:

    repo init -u https://github.com/minimal-manifest-twrp/platform_manifest_twrp_aosp.git -b twrp-12.1

To initialize a shallow clone, which will save even more space, use a command like this:

    repo init --depth=1 -u https://github.com/minimal-manifest-twrp/platform_manifest_twrp_aosp.git -b twrp-12.1

Then to sync up:

    repo sync

Then clone device tree:

     git clone https://github.com/skyhuppa/device_realme_recovery_RMX5070 -b twrp-12.1

Then to setup the build:

     cd <source-dir>; export ALLOW_MISSING_DEPENDENCIES=true; . build/envsetup.sh; lunch twrp_<device>-eng

The build target is dependent on the device, and should reflect the location of stock recovery on the device. Issue the build command that applies to your device:
- Recovery partition: `mka recoveryimage`
- Boot image ramdisk: `mka bootimage`
- Vendor_boot image ramdisk: `mka vendorbootimage`

### Special Notes for this branch
- Build completed successfully for this device tree branch.
- recoveryimage/vendorbootimage not tested on RMX5070 devices because I don't have access to this device.
- Whenever bootloader is unlocked fork this branch and update for booting.

Credits goes to  TWRP TEAM
