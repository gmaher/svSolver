#
# Copyright (c) 2014-2015 The Regents of the University of California.
# All Rights Reserved.
#
# Portions of the code Copyright (c) 2009-2011 Open Source Medical
# Software Corporation, University of California, San Diego.
# All rights reserved.
#
# Permission is hereby granted, free of charge, to any person obtaining
# a copy of this software and associated documentation files (the
# "Software"), to deal in the Software without restriction, including
# without limitation the rights to use, copy, modify, merge, publish,
# distribute, sublicense, and/or sell copies of the Software, and to
# permit persons to whom the Software is furnished to do so, subject
# to the following conditions:
#
# The above copyright notice and this permission notice shall be included
# in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
# OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
# IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
# CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
# TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
# SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
#

set SV_TIMESTAMP [lindex $argv 0]
set SV_RELEASE_VERSION_NO [lindex $argv 1]
set package_path [lindex $argv 2]

global pwd
if {$tcl_platform(platform) == "windows"} {
  set pwd [pwd]
} else {
  #assume cygwin
  set pwd [exec cygpath -m [pwd]]
}

puts "building wxs for $argv"

set outputRegistry 0

proc file_find {dir wildcard args} {

  global pwd
  global SV_TIMESTAMP
  
  if {[llength $args] == 0} {
     set rtnme {}
  } else {
     upvar rtnme rtnme
  }

  foreach j $dir {
    set files [glob -nocomplain [file join $j $wildcard]]
    puts "files: $files"
    # print out headers
    global idno
    global outfp
    set id [incr idno]
    global component_ids
    lappend component_ids $id
    set guid [exec tmp/uuidgen.exe 1]
    puts $outfp "<Component Id='id[format %04i $id]' Guid='$guid'>"
    global outputRegistry
    if {!$outputRegistry} {
        set outputRegistry 1
        set regid 11
        puts $outfp "<Registry Id='regid$regid' Root='HKLM' Key='Software\\SimVascular\\svSolver\\$SV_TIMESTAMP' Name='SVSOLVER_HOME' Action='write' Type='string' Value='\[INSTALLDIR\]$SV_TIMESTAMP' />"
        incr regid
	puts $outfp "<Registry Id='regid$regid' Root='HKLM' Key='Software\\SimVascular\\svSolver\\$SV_TIMESTAMP' Name='TimeStamp' Action='write' Type='string' Value='$SV_TIMESTAMP' />"
	incr regid
	puts $outfp "<Registry Id='regid$regid' Root='HKLM' Key='Software\\SimVascular\\svSolver\\$SV_TIMESTAMP' Name='SVPRE_EXE' Action='write' Type='string' Value='\[INSTALLDIR\]$SV_TIMESTAMP\\svpre-bin.exe' />"
        incr regid
        puts $outfp "<Registry Id='regid$regid' Root='HKLM' Key='Software\\SimVascular\\svSolver\\$SV_TIMESTAMP' Name='SVPOST_EXE' Action='write' Type='string' Value='\[INSTALLDIR\]$SV_TIMESTAMP\\svpost-bin.exe' />"
        incr regid
        puts $outfp "<Registry Id='regid$regid' Root='HKLM' Key='Software\\SimVascular\\svSolver\\$SV_TIMESTAMP' Name='SVSOLVER_NOMPI_EXE' Action='write' Type='string' Value='\[INSTALLDIR\]$SV_TIMESTAMP\\svsolver-nompi-bin.exe'  />"
        incr regid
	puts $outfp "<Registry Id='regid$regid' Root='HKLM' Key='Software\\SimVascular\\svSolver\\$SV_TIMESTAMP' Name='SVSOLVER_MSMPI_EXE' Action='write' Type='string' Value='\[INSTALLDIR\]$SV_TIMESTAMP\\svsolver-msmpi-bin.exe'  />"
        incr regid
    }
    foreach i $files {
      global outfp
      if {![file isdirectory $i]} {
        global idno
	set id [incr idno]
	puts $outfp "<File Id='id[format %04i $id]' Name='[file tail $i]' Source='$pwd/$i' DiskId='1' />"
      }
      lappend rtnme $i
    }
    set id [incr idno]
    puts $outfp "<RemoveFile Id='id[format %04i $id]' On='uninstall' Name='*.*' />"
    set id [incr idno]
    puts $outfp "<RemoveFolder Id='id[format %04i $id]' On='uninstall' />"
    puts $outfp "</Component>"

    set files [glob -nocomplain [file join $j *]]
    foreach i $files {
      if {[file isdirectory $i] == 1} {
	if {[file tail $i] != ".svn"} {
          global outfp
          global idno
	  set id [incr idno]
          global curdirID
          set curdirID "id[format %04i $id]"
	  puts $outfp "<Directory Id='id[format %04i $id]' Name='[file tail $i]'>"

          file_find $i $wildcard 1
          puts $outfp "</Directory>"
	}
      }
    }
  }
  return [lsort -unique $rtnme]

}

puts "building wxs for $argv"

set component_ids {}

set idno 1000

set outfp [open tmp/simvascular-svsolver.wxs w]

puts $outfp "<?xml version='1.0' encoding='windows-1252'?>"
puts $outfp "<Wix xmlns=\"http://schemas.microsoft.com/wix/2006/wi\""
puts $outfp "     xmlns:util=\"http://schemas.microsoft.com/wix/UtilExtension\">"

set product_id [exec tmp/uuidgen.exe 1]
set package_id [exec tmp/uuidgen.exe 1]
set upgrade_id [exec tmp/uuidgen.exe 1]

puts $outfp "<Product Name='SimVascular svSolver' Id='$product_id' UpgradeCode='$upgrade_id' Language='1033' Codepage='1252' Version='$SV_RELEASE_VERSION_NO' Manufacturer='SimVascular'>"
puts $outfp "<Package Id='$package_id' Keywords='Installer' Description='SimVascular svSolver Installer' Comments='SimVascular svSolver' Manufacturer='SimVascular' InstallerVersion='100' Languages='1033' Compressed='yes' Platform='x64' SummaryCodepage='1252' />"

puts $outfp "<WixVariable Id=\"WixUILicenseRtf\" Value=\"License.rtf\" />"
puts $outfp "<WixVariable Id=\"WixUIBannerBmp\" Value=\"windows_msi_helpers/msi-banner.bmp\" />"
puts $outfp "<WixVariable Id=\"WixUIDialogBmp\" Value=\"windows_msi_helpers/msi-dialog.bmp\" />"

puts $outfp "<Media Id='1' Cabinet='Sample.cab' EmbedCab='yes' />"
puts $outfp "<Property Id='INSTALLLEVEL' Value='999' />"
puts $outfp "<Property Id='ALLUSERS' Value='1' />" 

puts $outfp "<Directory Id='TARGETDIR' Name='SourceDir'>"
puts $outfp "\t<Directory Id='ProgramFiles64Folder' Name='PFiles'>"
puts $outfp "\t\t<Directory Id='id19' Name='SimVascular'>"
#puts $outfp "\t\t<Directory Id='id911' Name='svSolver'>"
puts $outfp "\t\t\t<Directory Id='INSTALLDIR' Name='svSolver'>"

#puts $outfp "<Component Id='ain_id23' Guid='A7FFADE1-74BB-4CC8-8052-06B214B93701'>"

#set id [incr idno]
#lappend component_ids $id
#set guid [exec tmp/uuidgen.exe 1]
#puts $outfp "<Component Id='id[format %04i $id]' Guid='$guid'>"

file_find $package_path *

#    set id [incr idno]
#    puts $outfp "<RemoveFile Id='id[format %04i $id]' On='uninstall' Name='*.*' />"
#    set id [incr idno]
#puts $outfp "<RemoveFolder Id='id[format %04i $id]' On='uninstall' />"


#puts $outfp "</Component>"
puts $outfp "\t\t\t</Directory>"
puts $outfp "\t\t\t</Directory>"
#puts $outfp "\t\t</Directory>"
puts $outfp "\t</Directory>"
puts $outfp "</Directory>"

#set id [incr idno]
#lappend component_ids $id
#set guid [exec tmp/uuidgen.exe 1]
#puts $outfp "\t\t<Component Id='id[format %04i $id]' Guid='$guid'>"
#puts $outfp "\t\t\t<RemoveFolder Id='RemoveProgramMenuDir' Directory='ProgramMenuDir' On='uninstall' />"
#puts $outfp "\t\t</Component>"
#puts $outfp "<Directory Id='ProgramMenuFolder' LongName='Programs'>"
#puts $outfp "\t<Directory Id='ProgramMenuDir' Name='svSolver'>"

#puts $outfp "\t</Directory>"
#puts $outfp "</Directory>"

puts $outfp "<Feature Id='Complete' Title='svSolver' Description='The complete package.' Display='expand' Level='1' ConfigurableDirectory='INSTALLDIR'>"
puts $outfp "\t<Feature Id='Main' Title='Main' Description='Required Files' Display='expand' Level='1'>"

# need components to match directories above!
foreach i $component_ids {
  puts $outfp "\t\t<ComponentRef Id='id$i' />"
}
#puts $outfp "\t\t<ComponentRef Id='ain_id23' />"
#puts $outfp "\t\t<ComponentRef Id='ain_id30' />"

puts $outfp "\t</Feature>"
puts $outfp "</Feature>"

puts $outfp "<Property Id='WIXUI_INSTALLDIR' Value='INSTALLDIR' />		<UIRef Id='WixUI_InstallDir' />"
puts $outfp "<Icon Id='idico' SourceFile='$pwd\\windows_msi_helpers\\simvascular.ico' />"
puts $outfp "</Product>"
puts $outfp "</Wix>"

close $outfp
