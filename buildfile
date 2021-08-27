
lib{rapidyaml}: upstream/rapidyaml/src/{hxx ixx txx cxx}{**} 
#lib{c4core}: upstream/rapidyaml/ext/c4core/src/{hxx ixx txx cxx}{**} 
#./: lib{rapidyaml} lib{c4core}

cxx.poptions =+ "-I$out_root" "-I$src_root"

#obja{*}: cxx.poptions += 
objs{*}: cxx.poptions += -DC4CORE_EXPORT

#lib{c4core}:
#{
#  cxx.export.poptions = "-I$out_root" "-I$src_root"
#}

lib{rapidyaml}: 
{
  cxx.export.poptions = "-I$out_root" "-I$src_root"
}

#liba{rapidyaml}: cxx.export.poptions += -DRAPIDYAML_STATIC
#libs{rapidyaml}: cxx.export.poptions += -DRAPIDYAML_SHARED

#liba{c4core}: cxx.export.poptions += -DRAPIDYAML_STATIC
#libs{c4core}: cxx.export.poptions += -DC4CORE_EXPORT


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
