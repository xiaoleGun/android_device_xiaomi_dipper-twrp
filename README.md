# Device tree for Xiaomi Mi 8 (codenamed _"dipper"_)

==================================

## Device specifications

Basic   | Spec Sheet
-------:|:-------------------------
SoC     | Qualcomm SDM845 Snapdragon 845
CPU     | Octa-core (4x2.8 GHz Kryo 385 Gold & 4x1.8 GHz Kryo 385 Silver)
GPU     | Adreno 630
Memory  | 6 GB RAM
Shipped Android Version | 8.1 with MIUI 9.5
Storage | 64/128/256 GB
Battery | Non-removable Li-Ion 3400 mAh battery
Display | 1080 x 2248 pixels, 18:9 ratio, 6.21 inches, Super AMOLED (~402 ppi density)
Camera  | Dual 12 MP, 4-axis OIS, 2x optical zoom, dual PDAF, dual-LED (dual tone) flash

## Device picture

![Xiaomi Mi 8](https://xiaomi-mi.com/uploads/CatalogueImage/01_b_16982_1527780977.jpg "Xiaomi Mi 8 in black")

## Building
Generally, see https://wiki.orangefox.tech/en/dev/building

### Variants
1. For standard mode, build without any additional flags.
2. To build for ROMs using retrofitted dynamic partitions, run "export FOX_USE_DYNAMIC_PARTITIONS=1" before building.
3. To build for ROMs using borrowed keymaster 4.0, run "export FOX_USE_KEYMASTER_4=1" before building.

### Kernel source
Clone this: "https://github.com/LineageOS/android_kernel_xiaomi_sdm845.git -b lineage-21"

## Copyright
 ```
  /*
  *  Copyright (C) 2018 The LineageOS Project
  *
  *  Copyright (C) 2019-2024 The OrangeFox Recovery Project
  *
  * This program is free software: you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
  * the Free Software Foundation, either version 3 of the License, or
  * (at your option) any later version.
  *
  * This program is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  * GNU General Public License for more details.
  *
  * You should have received a copy of the GNU General Public License
  * along with this program.  If not, see <http://www.gnu.org/licenses/>.
  *
  */
  ```
