#
# This file is part of the GROMACS molecular simulation package.
#
# Copyright (c) 2012, by the GROMACS development team, led by
# David van der Spoel, Berk Hess, Erik Lindahl, and including many
# others, as listed in the AUTHORS file in the top-level source
# directory and at http://www.gromacs.org.
#
# GROMACS is free software; you can redistribute it and/or
# modify it under the terms of the GNU Lesser General Public License
# as published by the Free Software Foundation; either version 2.1
# of the License, or (at your option) any later version.
#
# GROMACS is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
# Lesser General Public License for more details.
#
# You should have received a copy of the GNU Lesser General Public
# License along with GROMACS; if not, see
# http://www.gnu.org/licenses, or write to the Free Software Foundation,
# Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301  USA.
#
# If you want to redistribute modifications to GROMACS, please
# consider that scientific software is very special. Version
# control is crucial - bugs must be traceable. We will be happy to
# consider code for inclusion in the official distribution, but
# derived work must not be called official GROMACS. Details are found
# in the README & COPYING files - if they are missing, get the
# official version at http://www.gromacs.org.
#
# To help us fund GROMACS development, we humbly ask that you cite
# the research papers on the package. Check out http://www.gromacs.org.
#
# Custom build type "Reference", to be used for creating new
# reference values in the Gromacs regression tests.
set( CMAKE_CXX_FLAGS_REFERENCE "-O0 -g" CACHE STRING "C++ flags for regressiontests reference runs." FORCE)
set( CMAKE_C_FLAGS_REFERENCE "-O0 -g" CACHE STRING "C flags for regressiontests reference runs." FORCE)
mark_as_advanced( CMAKE_CXX_FLAGS_REFERENCE CMAKE_C_FLAGS_REFERENCE)

# turn off all fancy options for the regressiontests reference build
if("${CMAKE_BUILD_TYPE}" STREQUAL "Reference")
    set(GMX_GPU OFF CACHE BOOL "Disabled for regressiontests reference builds" FORCE)
    set(GMX_OPENMP OFF CACHE BOOL "Disabled for regressiontests reference builds" FORCE)
    set(GMX_CPU_ACCELERATION "None" CACHE STRING "Disabled for regressiontests reference builds" FORCE)
    set(GMX_FFT_LIBRARY "fftpack" CACHE STRING "Use fftpack for regressiontests reference builds" FORCE)
    set(GMX_SOFTWARE_INVSQRT OFF CACHE BOOL "Disabled for regressiontests reference builds" FORCE)
    set(GMX_THREAD_MPI OFF CACHE BOOL "Disabled for regressiontests reference builds" FORCE)

    # C_COMPILER_VERSION is not defined automatically for CMake below 2.8.8,
    # so we call the GROMACS work-around for that
    include(gmxGetCompilerInfo)
    get_compiler_version()
    if(NOT "${CMAKE_C_COMPILER_ID}" STREQUAL "GNU" OR NOT "${C_COMPILER_VERSION}" MATCHES "4.7")
        message(WARNING "Reference values for regressiontests should use Gromacs compiled with "
            "gcc 4.7, but your configuration is using ${CMAKE_C_COMPILER_ID}-${C_COMPILER_VERSION}.")
    endif()
endif()