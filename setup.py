# -*- coding: utf-8 -*-
from distutils.core import setup
from setuptools import find_packages
from distutils.extension import Extension
from Cython.Distutils import build_ext
from Cython.Build import cythonize

exts = [Extension("polyline_ggl/decode",
            ["polyline_ggl/decode.pyx"], ["polyline_ggl"]),
        Extension("polyline_ggl/encode",
            ["polyline_ggl/encode.pyx"], ["polyline_ggl"])]
setup(
    name="polyline_ggl",
    version="0.0.1",
    license="BSD",
    install_requires = ['cython'],
    ext_modules=cythonize(exts),
    cmdclass = {'build_ext': build_ext},
    packages=find_packages(),
    test_suite = 'tests',
)
