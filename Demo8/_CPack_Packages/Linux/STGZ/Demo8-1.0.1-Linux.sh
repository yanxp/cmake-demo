#!/bin/sh

# Display usage
cpack_usage()
{
  cat <<EOF
Usage: $0 [options]
Options: [defaults in brackets after descriptions]
  --help            print this message
  --prefix=dir      directory in which to install
  --include-subdir  include the Demo8-1.0.1-Linux subdirectory
  --exclude-subdir  exclude the Demo8-1.0.1-Linux subdirectory
EOF
  exit 1
}

cpack_echo_exit()
{
  echo $1
  exit 1
}

# Display version
cpack_version()
{
  echo "Demo8 Installer Version: 1.0.1, Copyright (c) Humanity"
}

# Helper function to fix windows paths.
cpack_fix_slashes ()
{
  echo "$1" | sed 's/\\/\//g'
}

interactive=TRUE
cpack_skip_license=FALSE
cpack_include_subdir=""
for a in "$@"; do
  if echo $a | grep "^--prefix=" > /dev/null 2> /dev/null; then
    cpack_prefix_dir=`echo $a | sed "s/^--prefix=//"`
    cpack_prefix_dir=`cpack_fix_slashes "${cpack_prefix_dir}"`
  fi
  if echo $a | grep "^--help" > /dev/null 2> /dev/null; then
    cpack_usage 
  fi
  if echo $a | grep "^--version" > /dev/null 2> /dev/null; then
    cpack_version 
    exit 2
  fi
  if echo $a | grep "^--include-subdir" > /dev/null 2> /dev/null; then
    cpack_include_subdir=TRUE
  fi
  if echo $a | grep "^--exclude-subdir" > /dev/null 2> /dev/null; then
    cpack_include_subdir=FALSE
  fi
  if echo $a | grep "^--skip-license" > /dev/null 2> /dev/null; then
    cpack_skip_license=TRUE
  fi
done

if [ "x${cpack_include_subdir}x" != "xx" -o "x${cpack_skip_license}x" = "xTRUEx" ]
then
  interactive=FALSE
fi

cpack_version
echo "This is a self-extracting archive."
toplevel="`pwd`"
if [ "x${cpack_prefix_dir}x" != "xx" ]
then
  toplevel="${cpack_prefix_dir}"
fi

echo "The archive will be extracted to: ${toplevel}"

if [ "x${interactive}x" = "xTRUEx" ]
then
  echo ""
  echo "If you want to stop extracting, please press <ctrl-C>."

  if [ "x${cpack_skip_license}x" != "xTRUEx" ]
  then
    more << '____cpack__here_doc____'
The MIT License (MIT)

Copyright (c) 2013 Joseph Pan(http://hahack.com)

Permission is hereby granted, free of charge, to any person obtaining a copy of
this software and associated documentation files (the "Software"), to deal in
the Software without restriction, including without limitation the rights to
use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
the Software, and to permit persons to whom the Software is furnished to do so,
subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

____cpack__here_doc____
    echo
    echo "Do you accept the license? [yN]: "
    read line leftover
    case ${line} in
      y* | Y*)
        cpack_license_accepted=TRUE;;
      *)
        echo "License not accepted. Exiting ..."
        exit 1;;
    esac
  fi

  if [ "x${cpack_include_subdir}x" = "xx" ]
  then
    echo "By default the Demo8 will be installed in:"
    echo "  \"${toplevel}/Demo8-1.0.1-Linux\""
    echo "Do you want to include the subdirectory Demo8-1.0.1-Linux?"
    echo "Saying no will install in: \"${toplevel}\" [Yn]: "
    read line leftover
    cpack_include_subdir=TRUE
    case ${line} in
      n* | N*)
        cpack_include_subdir=FALSE
    esac
  fi
fi

if [ "x${cpack_include_subdir}x" = "xTRUEx" ]
then
  toplevel="${toplevel}/Demo8-1.0.1-Linux"
  mkdir -p "${toplevel}"
fi
echo
echo "Using target directory: ${toplevel}"
echo "Extracting, please wait..."
echo ""

# take the archive portion of this file and pipe it to tar
# the NUMERIC parameter in this command should be one more
# than the number of lines in this header file
# there are tails which don't understand the "-n" argument, e.g. on SunOS
# OTOH there are tails which complain when not using the "-n" argument (e.g. GNU)
# so at first try to tail some file to see if tail fails if used with "-n"
# if so, don't use "-n"
use_new_tail_syntax="-n"
tail $use_new_tail_syntax +1 "$0" > /dev/null 2> /dev/null || use_new_tail_syntax=""

tail $use_new_tail_syntax +162 "$0" | gunzip | (cd "${toplevel}" && tar xf -) || cpack_echo_exit "Problem unpacking the Demo8-1.0.1-Linux"

echo "Unpacking finished successfully"

exit 0
#-----------------------------------------------------------
#      Start of TAR.GZ file
#-----------------------------------------------------------;

� �."[ �Z}p�_�߲�eB'�p	q�0X�l�v��F�LmC��GSs����%G:���C&JJ�N��m���L'�I3�����WƴM�4d�ұ$ISOJPw��Jw�;LRJ'S?������ݷ��o/	�'�bu�_�kNDR8�����$��Q�rq�;��5W�Y�䜵�NGm]M���s8���n�9����K�ve����l�JU�4��Вp(C܆��}oY��pDL�qHc.M���`t�����s�ĉC�ш����X���`8d�_Wl����0��H(�{�>�l㿦Ρ�WM�x��\us���Pu5'�������䢃���#A..JR8��B�י�����?=G���&_�Ɩ��B�w���i��Ҏ..�r���~	�;�Ƣ;�Ayr�B���T/�$义�n�	xB�U�M+יzj�T��2�x�w�����}:��5N<�k��k������}��f�)-��}�H�
<��|�,c�A���-D�X�S�y�G�g k�A/�r����f��/=�M*����G×� G�K�_mV�Y�k8~l0k��`W	v��O�86��/~��_'ԋ�5��F�/���$ϧ`�;e�h�*�[��}��k'�(��LC�(��P��sU���Ñ�P�PC]U����kd�l����K֧�|^��>@����|s��o�=���n��'H��
��m��v炢���y��"I��4�^��������}⡒�)~�Kg���������q�ԃ[�x��^>�d�[�,�嶞��{V��Ҏh�k������6�N|�A��0��s�@��S9�bۮ��g��e�V����r��������Oi�����<t�H�E�wN�J?�rY?���d��?	��2^�lL>�����ú	��O7��ʸuZ�� ���[ס��G�1|�	!����� ��"�0�G(�'��_q�Ǧ ~l�l�bL��񱪳����:��4�1��ؚ0%?,�D#�������`8"$�bP].k�{�qj�n��e5���q1������֖�&��^cw#xg�}&�?��t^I�."V�A�)U�3~�ʡ�TmD�S�9*�R��p�
W�*\]�G��p~�B!�?��B��Ƥ���e�ׅ�Jz��G����3�_�؃��,��Τ0U����ULM��L�65&�G�L�4��,�HdR��C��#"�*LĢ�bK��6>�?znzCg��1ң���Ȁ�'�a�X��P�b��pź�*2~��+�|{���r�puʺ�������\���!;��E��ڻrǮ����4lr5oz�?yE�9�[1ͭt1�G.�^�%ʺ��d;��J޻2}0N��Q�J[�y翅�ҙ�OR�S��y�-�I�9�'�{N�n���&���ebq��`>���>�6�<&���J�
I؝N�	���O����X��v|�'��ҽc|�7i6H�iI߅�O�&o����Xe:��|�R��wbrΒ��h�B��'����!��n09�	��x��qR�K�e���sDm�R��1���s(a�H�r�����ˤ�}�W���Y*}o�R�2R�֌�9�f:�{\n�fo2��Ԓ���Ւ|���z��<��M|�����K�v���$����O.㗸�t���wZ���y���G�M�=��q����n�6�0��?���!c�Q]�6��8>�qA{EЂ���^q�H)B┍O;>�9<�q�D���p$D��/��9T��m�yq�8W�˜�W��\c~��c���|��^��Yܤd��7�����Y 9�vw Ӑʹ�����Fp���἖�J��G�n�?�TJ>>Xm���u�Ż
G���V.���.:d/��}��6�����i^��,�II�߫8�[��EN'��l�N��h�}�쳖?��rr}�ʯ��Vǣ���a�����6x������5Z˱~��P����磞�����a�8%�����L�O��t8G,����/��EL�?����Sf%?��sy�L��H��?����ߌ���S�>������x. ~�|����M�+bd<�������i��!�F=ǲ���	x�N����wSZ�Դ����ID�綻�*gMB�{�.�õT������p:�&.{��U����.Up|�H�̥����ޟ��Ad�D%��ml���� �F��DZ�A$K}�x��#8?�K1%e��Zi���~?Q���~��w�vI���-�=�7�v�O�����e$�B��b�ał>��d7�� .:*���R����с�V^��'��A��3qE^��y	���3qE��\Fv2��K �=�=Y�>�c�����) �N��^�9��ʧ�� ���|cB��|R�jO�'
��%��mC�\@���/�	���of�H�[�L��9��?��Hy�Ԟ�g}`O�ɾ?�?����q��|J�Kt�G��!���`���%������`φlm�6cO����Efdӊ�iƞ��� 1�����v����v�b���{����y�ϖ�c_^����˖?�$�F��L�P_���^�TeO���h
����s�h�&Rڎ�g⻊L㺴}�=�gʧq��ҫ�O�yƞ�Gh�,�2�4.�۴~���>��Ӹ���>;� c�j��6{�ː6�C�%Z>S [����Ѓ�p���z�4��'+|?�9[��(k��T�����I�Z<7��i��z�����/��_�����E��@�[��ώ�*xIz^����_׉��x&���m�yO����3->?=Oi���_��W��ͺ����<��oɌo�OW��8������/s��)/�Ӳ�'�Ì�����ۘ�p�\�Y�?�'!�9�}�|�|�+�g��a�z��F�ᤜV�*K����d��Ϟ�U��r>�h�^E&�g���&%��&%�ݝ2��֚��96���9zL��C{M��:I��=������~jҿ_9b�ϫ�E��}���*2��K�����~_�ޫʬ_�2��Wy���U>���[���}�@�Y��bR\J�B� �uMBk��NA@�['A��'�t AF���h��_J�X\�'�>p����׻ݵ�JB� +��il)G�`b``��$!s�Ursf��;� �Ds���'��א0�J�Y���
ƣB�?$�ik��{�Z��j�Z����沶u}��UX�ܼ��)tz[}�g��S]ݑ�B�G}�F����Pn�r�M��
�e��P��Թ7$��L�7�Js�9 �+ȧ�a翾e���gm-N��]��_n����7��\���TsZr�k�q548�9�!#��WC89RAv3ϩ&I�]�"u~�`�V[�Z}�N��3���\$�����~�f�o�XQ��?�uf��%���6]����4'dt�Hb�4~�wgx�(��V"ڪ�3k���V_��U�GQ�0K���qHcӶQfoK�m[�f�^�& �Ic�H?��E��h�~`�/[�r���|Z{'ҏs>[����y�ˠ|�u|"tZS�Qڌ��?���Y�;�~�M�_!�n?�S98�.w�c��A&g�"��bL/����R��uRbO���'J�I�3�p��(��u�|���3=������@��	��rJ!N��}�0Gs4Gstu�7US� <  