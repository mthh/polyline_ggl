# -*- coding: utf-8 -*-
from distutils.core import setup
from setuptools import find_packages
from distutils.extension import Extension

exts = [Extension("polyline_ggl.decode",
            ["polyline_ggl/decode.pyx"], ["."]),
        Extension("polyline_ggl.encode",
            ["polyline_ggl/encode.pyx"], ["."])]
setup(
    name="polyline_ggl",
    version="0.0.1",
    license="BSD",
    install_requires = ['cython'],
    ext_modules=exts,
    packages=find_packages(),
    test_suite = 'tests',
)
