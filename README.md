This repository statically serves a Xeus Python Jupyter lite Webassembly environment wth most of the Python API for OpenMC preinstalled.

There are a few current limitations:
- The OpenMC executable is not included so you can't actually run OpenMC simulations. To include this OpenMC would need compiling for Webassembly with emscripten.
- h5py is also not available in the environment so you can't load h5 cross sections. This is due to h5py distribution not meeting the packaging requirments of either being a no-arch packages from conda-forge or an emscripten-forge package.

[https://shimwell.github.io/openmc-online-demo/](https://shimwell.github.io/openmc-online-demo/)