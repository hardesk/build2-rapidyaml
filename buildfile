C4CORE_FAST_FLOAT = ascii_number.h decimal_to_binary.h fast_float.h fast_table.h float_common.h parse_number.h simple_decimal_conversion.h

C4CORE_FILES = ext/c4core/src/c4/{hxx cxx}{*} \
        ext/c4core/src/c4/ext/debugbreak/hxx{debugbreak.h} \
        ext/c4core/src/c4/ext/sg14/hxx{inplace_function.h} \
		ext/c4core/src/c4/ext/fast_float/include/fast_float/hxx{$C4CORE_FAST_FLOAT} \
        ext/c4core/src/c4/ext/rng/{hxx}{rng} \
        ext/c4core/src/c4/ext/hxx{fast_float}

lib{rapidyaml}: src/{hxx cxx}{**} ext/c4core/src/{hxx cxx}{*} ext/c4core/src/ext/{hxx cxx}{** -fast_float} $C4CORE_FILES
cxx.poptions =+ "-I$src_root/src" "-I$src_root/ext/c4core/src" "-I$src_root/ext/c4core/src/c4/ext/fast_float/include"

#if ($cxx.target.class == 'windows')
#	objs{*}: cxx.poptions += -DC4CORE_EXPORTS

lib{rapidyaml}: 
{
  cxx.export.poptions =  "-I$src_root/src" "-I$src_root/ext/c4core/src" "-I$src_root/ext/c4core/src/c4/ext/fast_float/include"
}

# For pre-releases use the complete version to make sure they cannot be used
# in place of another pre-release or the final version. See the version module
# for details on the version.* variable values.
#
if $version.pre_release
  lib{rapidyaml}: bin.lib.version = @"-$version.project_id"
else
  lib{rapidyaml}: bin.lib.version = @"-$version.major.$version.minor"

# Install into the rapidyaml/ subdirectory of, say, /usr/include/
# recreating subdirectories.
#
{hxx ixx txx}{*}:
{
  install         = include/rapidyaml/
  install.subdirs = true
}
