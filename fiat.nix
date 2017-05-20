{ stdenv, coq, fetchFromGitHub, python }:
  let fiat-src = fetchFromGitHub
        { owner = "plv";
          repo = "fiat";
          githubBase = "github.mit.edu";
          varPrefix = "MIT";
          rev = "b26349257e53f12ed599dbd78962f2586e5dc7e6";
          sha256 = "0slqfzqb0dmgwvrygz0xp4f19h6nqp28j39gdhqv59ck6ql5jk6w";
          private = true;
        };
      coq-scripts-src = fetchFromGitHub
        { owner = "JasonGross";
          repo = "coq-scripts";
          rev = "d757382478b3d5094f56f84eec4c3bb9c50dddd8";
          sha256 = "1zdxa7bj717dip0jpkv6s03bj27nlczyxz6j9s0arm9f96k6q5nq";
        };
  in stdenv.mkDerivation
    { name = "fiat-2017-05-19";
      src = fiat-src;
      postUnpack = ''
        unpackFile ${coq-scripts-src}
        mkdir $sourceRoot/etc
        chmod +w -R coq-scripts*
        mv coq-scripts* $sourceRoot/etc/coq-scripts
      '';
      installFlags = [ "COQLIB=$(out)/lib/coq/${coq.coq-version}/" ];
      enableParallelBuilding = true;
      buildInputs = [ coq python coq.ocaml ];
    }
