#!/usr/bin/env python3
"""
Script to generate Xcode project for BabyNameGenerator iOS app
"""

import os
import uuid
import glob

def generate_uuid():
    """Generate a 24-character hex ID for Xcode"""
    return uuid.uuid4().hex[:24].upper()

def find_files(directory, extensions):
    """Find all files with given extensions"""
    files = []
    for ext in extensions:
        pattern = os.path.join(directory, '**', f'*.{ext}')
        files.extend(glob.glob(pattern, recursive=True))
    return sorted(files)

# Project directory
project_dir = '/Users/user/Documents/Web development/2025/baby_name_generator'
os.chdir(project_dir)

# Find all source files
swift_files = find_files('BabyNameGenerator', ['swift'])
json_files = find_files('BabyNameGenerator', ['json'])

print(f"Found {len(swift_files)} Swift files")
print(f"Found {len(json_files)} JSON files")

# Generate IDs
ids = {}
for file in swift_files + json_files:
    basename = os.path.basename(file)
    ids[file] = {
        'file_ref': generate_uuid(),
        'build_file': generate_uuid()
    }

# Additional IDs
app_id = generate_uuid()
target_id = generate_uuid()
project_id = generate_uuid()
products_group_id = generate_uuid()
main_group_id = generate_uuid()
source_group_id = generate_uuid()
frameworks_phase_id = generate_uuid()
sources_phase_id = generate_uuid()
resources_phase_id = generate_uuid()
config_list_project = generate_uuid()
config_list_target = generate_uuid()
debug_project = generate_uuid()
release_project = generate_uuid()
debug_target = generate_uuid()
release_target = generate_uuid()

# Build file references section
build_files = []
for file, id_dict in ids.items():
    basename = os.path.basename(file)
    if file.endswith('.swift'):
        build_files.append(f'\t\t{id_dict["build_file"]} /* {basename} in Sources */ = {{isa = PBXBuildFile; fileRef = {id_dict["file_ref"]} /* {basename} */; }};')
    else:
        build_files.append(f'\t\t{id_dict["build_file"]} /* {basename} in Resources */ = {{isa = PBXBuildFile; fileRef = {id_dict["file_ref"]} /* {basename} */; }};')

# File references section
file_refs = [f'\t\t{app_id} /* BabyNameGenerator.app */ = {{isa = PBXFileReference; explicitFileType = wrapper.application; includeInIndex = 0; path = BabyNameGenerator.app; sourceTree = BUILT_PRODUCTS_DIR; }};']
for file, id_dict in ids.items():
    basename = os.path.basename(file)
    relpath = os.path.relpath(file, 'BabyNameGenerator')
    if file.endswith('.swift'):
        file_refs.append(f'\t\t{id_dict["file_ref"]} /* {basename} */ = {{isa = PBXFileReference; lastKnownFileType = sourcecode.swift; path = "{relpath}"; sourceTree = "<group>"; }};')
    elif file.endswith('.json'):
        file_refs.append(f'\t\t{id_dict["file_ref"]} /* {basename} */ = {{isa = PBXFileReference; lastKnownFileType = text.json; path = "{relpath}"; sourceTree = "<group>"; }};')

# Sources build phase
sources_files = [f'\t\t\t\t{ids[f]["build_file"]} /* {os.path.basename(f)} in Sources */,' for f in swift_files]

# Resources build phase
resources_files = [f'\t\t\t\t{ids[f]["build_file"]} /* {os.path.basename(f)} in Resources */,' for f in json_files]

# Group children
group_children = [f'\t\t\t\t{ids[f]["file_ref"]} /* {os.path.basename(f)} */,' for f in swift_files + json_files]

# Create project.pbxproj
pbxproj_content = f'''// !$*UTF8*$!
{{
\tarchiveVersion = 1;
\tclasses = {{
\t}};
\tobjectVersion = 56;
\tobjects = {{

/* Begin PBXBuildFile section */
{chr(10).join(build_files)}
/* End PBXBuildFile section */

/* Begin PBXFileReference section */
{chr(10).join(file_refs)}
/* End PBXFileReference section */

/* Begin PBXFrameworksBuildPhase section */
\t\t{frameworks_phase_id} /* Frameworks */ = {{
\t\t\tisa = PBXFrameworksBuildPhase;
\t\t\tbuildActionMask = 2147483647;
\t\t\tfiles = (
\t\t\t);
\t\t\trunOnlyForDeploymentPostprocessing = 0;
\t\t}};
/* End PBXFrameworksBuildPhase section */

/* Begin PBXGroup section */
\t\t{main_group_id} = {{
\t\t\tisa = PBXGroup;
\t\t\tchildren = (
\t\t\t\t{source_group_id} /* BabyNameGenerator */,
\t\t\t\t{products_group_id} /* Products */,
\t\t\t);
\t\t\tsourceTree = "<group>";
\t\t}};
\t\t{source_group_id} /* BabyNameGenerator */ = {{
\t\t\tisa = PBXGroup;
\t\t\tchildren = (
{chr(10).join(group_children)}
\t\t\t);
\t\t\tpath = BabyNameGenerator;
\t\t\tsourceTree = "<group>";
\t\t}};
\t\t{products_group_id} /* Products */ = {{
\t\t\tisa = PBXGroup;
\t\t\tchildren = (
\t\t\t\t{app_id} /* BabyNameGenerator.app */,
\t\t\t);
\t\t\tname = Products;
\t\t\tsourceTree = "<group>";
\t\t}};
/* End PBXGroup section */

/* Begin PBXNativeTarget section */
\t\t{target_id} /* BabyNameGenerator */ = {{
\t\t\tisa = PBXNativeTarget;
\t\t\tbuildConfigurationList = {config_list_target} /* Build configuration list for PBXNativeTarget "BabyNameGenerator" */;
\t\t\tbuildPhases = (
\t\t\t\t{sources_phase_id} /* Sources */,
\t\t\t\t{frameworks_phase_id} /* Frameworks */,
\t\t\t\t{resources_phase_id} /* Resources */,
\t\t\t);
\t\t\tbuildRules = (
\t\t\t);
\t\t\tdependencies = (
\t\t\t);
\t\t\tname = BabyNameGenerator;
\t\t\tproductName = BabyNameGenerator;
\t\t\tproductReference = {app_id} /* BabyNameGenerator.app */;
\t\t\tproductType = "com.apple.product-type.application";
\t\t}};
/* End PBXNativeTarget section */

/* Begin PBXProject section */
\t\t{project_id} /* Project object */ = {{
\t\t\tisa = PBXProject;
\t\t\tattributes = {{
\t\t\t\tBuildIndependentTargetsInParallel = 1;
\t\t\t\tLastSwiftUpdateCheck = 1500;
\t\t\t\tLastUpgradeCheck = 1500;
\t\t\t}};
\t\t\tbuildConfigurationList = {config_list_project} /* Build configuration list for PBXProject "BabyNameGenerator" */;
\t\t\tcompatibilityVersion = "Xcode 14.0";
\t\t\tdevelopmentRegion = en;
\t\t\thasScannedForEncodings = 0;
\t\t\tknownRegions = (
\t\t\t\ten,
\t\t\t\tBase,
\t\t\t);
\t\t\tmainGroup = {main_group_id};
\t\t\tproductRefGroup = {products_group_id} /* Products */;
\t\t\tprojectDirPath = "";
\t\t\tprojectRoot = "";
\t\t\ttargets = (
\t\t\t\t{target_id} /* BabyNameGenerator */,
\t\t\t);
\t\t}};
/* End PBXProject section */

/* Begin PBXResourcesBuildPhase section */
\t\t{resources_phase_id} /* Resources */ = {{
\t\t\tisa = PBXResourcesBuildPhase;
\t\t\tbuildActionMask = 2147483647;
\t\t\tfiles = (
{chr(10).join(resources_files)}
\t\t\t);
\t\t\trunOnlyForDeploymentPostprocessing = 0;
\t\t}};
/* End PBXResourcesBuildPhase section */

/* Begin PBXSourcesBuildPhase section */
\t\t{sources_phase_id} /* Sources */ = {{
\t\t\tisa = PBXSourcesBuildPhase;
\t\t\tbuildActionMask = 2147483647;
\t\t\tfiles = (
{chr(10).join(sources_files)}
\t\t\t);
\t\t\trunOnlyForDeploymentPostprocessing = 0;
\t\t}};
/* End PBXSourcesBuildPhase section */

/* Begin XCBuildConfiguration section */
\t\t{debug_project} /* Debug */ = {{
\t\t\tisa = XCBuildConfiguration;
\t\t\tbuildSettings = {{
\t\t\t\tALWAYS_SEARCH_USER_PATHS = NO;
\t\t\t\tCLANG_ENABLE_MODULES = YES;
\t\t\t\tCLANG_ENABLE_OBJC_ARC = YES;
\t\t\t\tCOPY_PHASE_STRIP = NO;
\t\t\t\tDEBUG_INFORMATION_FORMAT = dwarf;
\t\t\t\tENABLE_TESTABILITY = YES;
\t\t\t\tGCC_C_LANGUAGE_STANDARD = gnu17;
\t\t\t\tGCC_DYNAMIC_NO_PIC = NO;
\t\t\t\tGCC_NO_COMMON_BLOCKS = YES;
\t\t\t\tGCC_OPTIMIZATION_LEVEL = 0;
\t\t\t\tGCC_PREPROCESSOR_DEFINITIONS = (
\t\t\t\t\t"DEBUG=1",
\t\t\t\t\t"$(inherited)",
\t\t\t\t);
\t\t\t\tIPHONEOS_DEPLOYMENT_TARGET = 15.0;
\t\t\t\tONLY_ACTIVE_ARCH = YES;
\t\t\t\tSDKROOT = iphoneos;
\t\t\t\tSWIFT_ACTIVE_COMPILATION_CONDITIONS = "DEBUG $(inherited)";
\t\t\t\tSWIFT_OPTIMIZATION_LEVEL = "-Onone";
\t\t\t}};
\t\t\tname = Debug;
\t\t}};
\t\t{release_project} /* Release */ = {{
\t\t\tisa = XCBuildConfiguration;
\t\t\tbuildSettings = {{
\t\t\t\tALWAYS_SEARCH_USER_PATHS = NO;
\t\t\t\tCLANG_ENABLE_MODULES = YES;
\t\t\t\tCLANG_ENABLE_OBJC_ARC = YES;
\t\t\t\tCOPY_PHASE_STRIP = NO;
\t\t\t\tDEBUG_INFORMATION_FORMAT = "dwarf-with-dsym";
\t\t\t\tENABLE_NS_ASSERTIONS = NO;
\t\t\t\tGCC_C_LANGUAGE_STANDARD = gnu17;
\t\t\t\tGCC_NO_COMMON_BLOCKS = YES;
\t\t\t\tIPHONEOS_DEPLOYMENT_TARGET = 15.0;
\t\t\t\tSDKROOT = iphoneos;
\t\t\t\tSWIFT_COMPILATION_MODE = wholemodule;
\t\t\t\tVALIDATE_PRODUCT = YES;
\t\t\t}};
\t\t\tname = Release;
\t\t}};
\t\t{debug_target} /* Debug */ = {{
\t\t\tisa = XCBuildConfiguration;
\t\t\tbuildSettings = {{
\t\t\t\tASSETCATALOG_COMPILER_APPICON_NAME = AppIcon;
\t\t\t\tCODE_SIGN_STYLE = Automatic;
\t\t\t\tCURRENT_PROJECT_VERSION = 1;
\t\t\t\tDEVELOPMENT_TEAM = "";
\t\t\t\tENABLE_PREVIEWS = YES;
\t\t\t\tGENERATE_INFOPLIST_FILE = YES;
\t\t\t\tINFOPLIST_KEY_UIApplicationSceneManifest_Generation = YES;
\t\t\t\tINFOPLIST_KEY_UIApplicationSupportsIndirectInputEvents = YES;
\t\t\t\tINFOPLIST_KEY_UILaunchScreen_Generation = YES;
\t\t\t\tINFOPLIST_KEY_UISupportedInterfaceOrientations = UIInterfaceOrientationPortrait;
\t\t\t\tINFOPLIST_KEY_UISupportedInterfaceOrientations_iPad = "UIInterfaceOrientationPortrait UIInterfaceOrientationPortraitUpsideDown UIInterfaceOrientationLandscapeLeft UIInterfaceOrientationLandscapeRight";
\t\t\t\tIPHONEOS_DEPLOYMENT_TARGET = 15.0;
\t\t\t\tLD_RUNPATH_SEARCH_PATHS = (
\t\t\t\t\t"$(inherited)",
\t\t\t\t\t"@executable_path/Frameworks",
\t\t\t\t);
\t\t\t\tMARKETING_VERSION = 1.0;
\t\t\t\tPRODUCT_BUNDLE_IDENTIFIER = com.babynames.BabyNameGenerator;
\t\t\t\tPRODUCT_NAME = "$(TARGET_NAME)";
\t\t\t\tSWIFT_EMIT_LOC_STRINGS = YES;
\t\t\t\tSWIFT_VERSION = 5.0;
\t\t\t\tTARGETED_DEVICE_FAMILY = "1,2";
\t\t\t}};
\t\t\tname = Debug;
\t\t}};
\t\t{release_target} /* Release */ = {{
\t\t\tisa = XCBuildConfiguration;
\t\t\tbuildSettings = {{
\t\t\t\tASSETCATALOG_COMPILER_APPICON_NAME = AppIcon;
\t\t\t\tCODE_SIGN_STYLE = Automatic;
\t\t\t\tCURRENT_PROJECT_VERSION = 1;
\t\t\t\tDEVELOPMENT_TEAM = "";
\t\t\t\tENABLE_PREVIEWS = YES;
\t\t\t\tGENERATE_INFOPLIST_FILE = YES;
\t\t\t\tINFOPLIST_KEY_UIApplicationSceneManifest_Generation = YES;
\t\t\t\tINFOPLIST_KEY_UIApplicationSupportsIndirectInputEvents = YES;
\t\t\t\tINFOPLIST_KEY_UILaunchScreen_Generation = YES;
\t\t\t\tINFOPLIST_KEY_UISupportedInterfaceOrientations = UIInterfaceOrientationPortrait;
\t\t\t\tINFOPLIST_KEY_UISupportedInterfaceOrientations_iPad = "UIInterfaceOrientationPortrait UIInterfaceOrientationPortraitUpsideDown UIInterfaceOrientationLandscapeLeft UIInterfaceOrientationLandscapeRight";
\t\t\t\tIPHONEOS_DEPLOYMENT_TARGET = 15.0;
\t\t\t\tLD_RUNPATH_SEARCH_PATHS = (
\t\t\t\t\t"$(inherited)",
\t\t\t\t\t"@executable_path/Frameworks",
\t\t\t\t);
\t\t\t\tMARKETING_VERSION = 1.0;
\t\t\t\tPRODUCT_BUNDLE_IDENTIFIER = com.babynames.BabyNameGenerator;
\t\t\t\tPRODUCT_NAME = "$(TARGET_NAME)";
\t\t\t\tSWIFT_EMIT_LOC_STRINGS = YES;
\t\t\t\tSWIFT_VERSION = 5.0;
\t\t\t\tTARGETED_DEVICE_FAMILY = "1,2";
\t\t\t}};
\t\t\tname = Release;
\t\t}};
/* End XCBuildConfiguration section */

/* Begin XCConfigurationList section */
\t\t{config_list_target} /* Build configuration list for PBXNativeTarget "BabyNameGenerator" */ = {{
\t\t\tisa = XCConfigurationList;
\t\t\tbuildConfigurations = (
\t\t\t\t{debug_target} /* Debug */,
\t\t\t\t{release_target} /* Release */,
\t\t\t);
\t\t\tdefaultConfigurationIsVisible = 0;
\t\t\tdefaultConfigurationName = Release;
\t\t}};
\t\t{config_list_project} /* Build configuration list for PBXProject "BabyNameGenerator" */ = {{
\t\t\tisa = XCConfigurationList;
\t\t\tbuildConfigurations = (
\t\t\t\t{debug_project} /* Debug */,
\t\t\t\t{release_project} /* Release */,
\t\t\t);
\t\t\tdefaultConfigurationIsVisible = 0;
\t\t\tdefaultConfigurationName = Release;
\t\t}};
/* End XCConfigurationList section */
\t}};
\trootObject = {project_id} /* Project object */;
}}
'''

# Create the project directory and file
os.makedirs('BabyNameGenerator.xcodeproj', exist_ok=True)
with open('BabyNameGenerator.xcodeproj/project.pbxproj', 'w') as f:
    f.write(pbxproj_content)

print("\n✅ Xcode project created successfully!")
print(f"📁 Project: BabyNameGenerator.xcodeproj")
print(f"📄 Files included: {len(swift_files + json_files)}")
