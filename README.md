## ✨ Try it in your browser ✨

👉 [https://shimwell.github.io/openmc-online-demo/](https://shimwell.github.io/openmc-online-demo/)

## More Details

This repository statically serves a [Xeus Python Jupyter lite](https://github.com/jupyterlite/xeus-python-demo) Web assembly environment wth most of the Python API for OpenMC preinstalled. The execution of code within the Jupyter notebook is performed locally within the sand boxed environment, not on a remote server. For more details see the excellent [Xeus-python-demo github repo](https://github.com/jupyterlite/xeus-python-demo)

There are a few current limitations:
- The OpenMC executable is not included so you can't actually run OpenMC simulations. To include this OpenMC would need compiling for Webassembly with emscripten or similar.
- h5py is also not available in the environment so you can't load h5 cross sections. This is due to h5py distribution not meeting the packaging requirements of either being a no-arch packages from conda-forge or an emscripten-forge package.
