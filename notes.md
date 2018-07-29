
- Install BerryConda          py36

- pip install putils psutil pytest-cov

- Install conda-build 3.3     py36               .

- Get conda-build recipe                         .
- Build conda-build 3.12      py3.6              .
- Install conda-build 3.12    py3.6              <- skip point

- Get anaconda python recipe  py3.6              .
- Build python 3.4            py3.6 --py34 flag  .
- Create python 3.4 env       py3.4              <- skip point

... if we are just using pip, should we just use stock python ..?
- pip install TF dependencies
- pip install TF 34 wheel
- pip install keras

python 3.4 build.sh

sed -i 's|-Werror=declaration-after-statement||g' \  
# replace '-Werror=declaration-after-statement' '' \
    $PREFIX/lib/python3.4/_sysconfigdata.py \
    $PREFIX/lib/python3.4/config-3.4m/Makefile




- name: Download Conda
  get_url:
    dest: /tmp/conda.sh
    url: "{{ CONDA_PKG }}"
    mode: 0777
    validate_certs: no

- name: Add conda $PATH for root
  lineinfile:
    name: ~/.bashrc
    line: export PATH=/opt/conda/bin:$PATH
    create: true

# File does not exist on BerryConda
- name: Add profile.d/conda.sh to armv7hf
  copy:
    src: conda.sh
    dest: /opt/conda/etc/profile.d/
  when: RCD_ARCH=="armv7hf"

- name: Setup Conda for interactive sessions
  lineinfile:
    name: ~/.bashrc
    line: . /opt/conda/etc/profile.d/conda.sh
    create: true

- name: Setup Conda for interactive sessions
  file:
    path: /etc/profile.d/conda.sh
    state: link
    src: /opt/conda/etc/profile.d/conda.sh

# Do not use a venv b/c this is a single purpose container
# and it is hard to keep them active in non-interactive
# sessions.

## This is just a convenience so the root env isn't polluted
#- name: Create base env on armv7hf
#  shell: /opt/conda/bin/conda create -n base --clone root
#  when: RCD_ARCH=="armv7hf"

## Only works with official conda package
#- name: Start in default virtual env for interactive sessions
#  lineinfile:
#    name: ~/.bashrc
#    line: source activate base
##  when: RCD_ARCH=="amd64"

- name: Update conda
  shell: /opt/conda/bin/conda update -y conda python

- name: Update pip (conda pip is behind on BerryConda)
  pip:
    name: pip
    extra_args: "--no-cache-dir --upgrade"
    executable: /opt/conda/bin/pip
    
conda install conda-build

apt install git build-essential

git clone anaconda/recipes
cd anaconda/recipes/python-3.4
conda-build .

# could theoretically get tensorflow, keras this way
