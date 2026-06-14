# For Re-SukiSu:

## Before Beginning

### SUSFS is NOT Available
Due to significant API discrepancies between the version used by ReSukiSu and SUSFS (v1.5), backporting is too highly volatile to continue.

**SUSFS IS CURRENTLY NON-FUNCTIONAL AND MAY REMAIN UNRESOLVED INDEFINITELY.** However, running ReSukiSu standalone works perfectly fine.

### Potential Stability & Security Risks
To force compatibility with MTK's proprietary closed-source kernel modules, **MODULE_SIG, MODVERSION, AND CLANG CFI HAVE BEEN PRACTICALLY DISABLEMENT / BYPASSED.**

Specifically, I have physically neutralized the CFI failure hooks. While CFI remains configured as `Enforcing` in the configuration file to maintain correct structure sizes, **the kernel will now blindly permit all indirect jumps.** Furthermore, MODVERSION verification functions have been stripped to bypass symbol version constraints.

**This project heavily trades system security and hardening for root accessibility. By using this kernel, you acknowledge that your device may face unpredictable security vulnerabilities or kernel panics. You are solely responsible for any data loss, soft-bricks, or security breaches.**

## STEP0: Clone Repos
```shell
git clone https://github.com/oppo-source/android_kernel_modules_oppo_mtk5g android_kernel_4.14_oppo_mtk5g_resukisu
cd android_kernel_4.14_oppo_mtk5g_resukisu
git clone https://github.com/AkinaHaruka/android_kernel_4.14_oppo_mtk5g_resukisu kernel-4.14
cd kernel-4.14
```

## STEP1: Add Re-SukiSu Modules
Please run this on the project root dir

```shell
curl -LSs "https://raw.githubusercontent.com/ReSukiSU/ReSukiSU/main/kernel/setup.sh" | bash
```

## STEP2: Get built config
Get a available make config from your phones and place it into `out/.config`
```shell
# To be reference only
# run it on your phone
zcat /proc/config.gz > /storage/emulated/0/Download/config.txt
# run it on your computer
mkdir out
adb pull /storage/emulated/0/Download/config.txt out/
```

## STEP3: Prepare Toolchains
```shell
git clone https://android.googlesource.com/platform/prebuilts/gcc/linux-x86/aarch64/aarch64-linux-android-4.9 -b ndk-release-r21 --depth=1 ./toolchains/gcc64
git clone https://android.googlesource.com/platform/prebuilts/clang/host/linux-x86 -b llvm-r383902b/clang-r383902 --depth=1 ./toolchains/clang
```
## STEP4: Sync build config
```shell
make O=out ARCH=arm64 olddefconfig
```
Edit `out/.config` match this:
```plain
CONFIG_KSU=y
CONFIG_KSU_MANUAL_HOOK=y
# CONFIG_MODULE_SIG is not set
CONFIG_THINLTO=y
# CONFIG_LTO_NONE is not set
CONFIG_LTO_CLANG=y
CONFIG_CFI=y
# CONFIG_CFI_PERMISSIVE is not set
CONFIG_CFI_CLANG=y
```
And sync again
```shell
make O=out ARCH=arm64 olddefconfig
```
## STEP5: Build
```
chmod a+x ./build.sh
./build.sh
```

## STEP6: Get build target files
Your kernel is located in `out/arch/arm64/boot/Image`

Use `magiskboot` tools to replace it into your `boot.img`

## In Use
When using SukiSu, Please avoid use `Hybrid Mount` as meta module, it may prevent your phone from booting.

You can try using it.If you met boot loop, you can press up and down `VOL-` at least **3 times** to enable Safe Mode.


# LICENSE
Closing the source code after modified or using for commercial purposes is prohibited.

Using for cheating in any online competitive game is prohibited.
