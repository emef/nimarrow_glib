[![nimarrow-glib CI](https://github.com/emef/nimarrow_glib/actions/workflows/ci.yml/badge.svg)](https://github.com/emef/nimarrow_glib/actions/workflows/ci.yml)

## Installation Notes
To install the arrow/parquet libs on debian:

```
sudo apt update
sudo apt install -y -V ca-certificates lsb-release wget
wget https://apache.jfrog.io/artifactory/arrow/$(lsb_release --id --short | tr 'A-Z' 'a-z')/apache-arrow-apt-source-latest-$(lsb_release --codename --short).deb
sudo apt install -y -V ./apache-arrow-apt-source-latest-$(lsb_release --codename --short).deb
sudo apt update
sudo apt install -y -V libparquet-glib-dev # For Apache Parquet GLib (C)
```

Installing pyarrow for testing results:

```
sudo apt install -y -V libarrow-python-dev

export PYARROW_WITH_PARQUET=1
export PYARROW_WITH_DATASET=1
pip install pyarrow
```

## C API
The goal is to cover all/most of the functions defined in the arrow
and parquet libraries referenced here: https://arrow.apache.org/docs/c_glib/

#### Data

- [x] Basic array classes
- [ ] Composite array classes
- [ ] Array builder classes
- [ ] GArrowTensor — Tensor class
- [ ] 128-bit and 256-bit decimal classes
- [x] GArrowType — Type mapping between Arrow and arrow-glib
- [x] Basic data type classes
- [ ] Composite data type classes
- [ ] GArrowField — Field class
- [ ] GArrowSchema — Schema class
- [ ] GArrowTable — Table class
- [ ] Record batch related classes
- [ ] GArrowChunkedArray — Chunked array class
- [ ] Table builder classes
- [ ] Computation on data
- [ ] Datum classes
- [x] Buffer classes
- [ ] Codec related type and class
- [ ] GArrowError — Error code mapping between Arrow and arrow-glib

#### File system API

- [ ] File system classes
- [ ] Local file system classes

#### IO

- [ ] GArrowFileMode — File mode mapping between Arrow and arrow-glib
- [ ] GArrowReadable — Input interface
- [ ] Input stream classes
- [ ] GArrowWritable — Output interface
- [ ] GArrowWritableFile — File output interface
- [ ] Output stream classes
- [ ] GArrowFile — File interface

#### IPC

- [ ] GArrowMetadataVersion — Metadata version mapgging between Arrow and arrow-glib
- [ ] IPC options classes
- [ ] Reader classes
- [ ] ORC reader
- [ ] Writer classes

#### GPU

- [ ] CUDA related classes