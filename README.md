# HenonStokesConst-1-3


A set of scripts that compute the Stokes constant for 2 instances of the Henon map. I assume that someone who is interested in this already knows what is the point of the Stokes constant, so I will not explain anything here. There will be a paper that explains this and the procedure soon, unfortunately it is not available yet.

The equations were embedded as images since there is no native support for them. They are ugly and misalligned, but it will make do.


The folder `Henon` has the scripts that compute the Stokes constant of the map

![equation](http://www.sciweavers.org/tex2img.php?eq=%5Cbegin%7Bpmatrix%7D%0A%20x%20%5C%5C%20y%0A%5Cend%7Bpmatrix%7D%0A%5Cmapsto%0A%5Cbegin%7Bpmatrix%7D%0A%20%20x%20%2B%202%20y%20%2B%20g%28x%2Cy%29%20%5C%5C%20y%20%2B%20g%28x%2Cy%29%0A%5Cend%7Bpmatrix%7D&bc=White&fc=Black&im=jpg&fs=12&ff=arev&edit=0)

with ![equation](http://www.sciweavers.org/tex2img.php?eq=g%28x%2Cy%29%20%3D%20%5Cfrac%7B3%7D%7B4%7D%20%281-%28x%2By%2B1%29%5E2%20%29&bc=White&fc=Black&im=jpg&fs=12&ff=arev&edit=0)
and the folder `RotHenon` has the scripts that compute the Stokes constant of the map

![equation](http://www.sciweavers.org/tex2img.php?eq=%5Cbegin%7Bpmatrix%7D%0A%20x%20%5C%5C%20y%0A%5Cend%7Bpmatrix%7D%0A%5Cmapsto%20T_%7B2%5Cpi%2F3%7D%5Ccdot%0A%5Cbegin%7Bpmatrix%7D%0A%20%20x%20%5C%5C%20y%20-%20x%5E2%0A%5Cend%7Bpmatrix%7D&bc=White&fc=Black&im=jpg&fs=12&ff=arev&edit=0)

with T_{2π/3} the 2π/3 rotation matrix.


For both maps the origin is a fixed point at 1:3 resonance and there exists a formal series ![equation](http://www.sciweavers.org/tex2img.php?eq=%5Ctilde%7BW%7D%28t%29%3D%5Csum_%7Bn%5Cge1%7Dw_n%20t%5E%7B-n%7D&bc=White&fc=Black&im=jpg&fs=12&ff=arev&edit=0) that satisfies formally the equation

![equation](http://www.sciweavers.org/tex2img.php?eq=%5Ctilde%7BW%7D%28t%2B1%29%20%3D%20H%28%5Ctilde%7BW%7D%28t%29%29&bc=White&fc=Black&im=jpg&fs=12&ff=arev&edit=0)

with $H$ being the respective map. Notice that ![equation](http://www.sciweavers.org/tex2img.php?eq=%5Ctilde%7BW%7D&bc=White&fc=Black&im=jpg&fs=12&ff=arev&edit=0) is a vector, so ![equation](http://www.sciweavers.org/tex2img.php?eq=w_n%5Cin%5Cmathbb%7BC%7D%5E2&bc=White&fc=Black&im=jpg&fs=12&ff=arev&edit=0).

Let ![equation](http://www.sciweavers.org/tex2img.php?eq=%5Ctilde%7BW%7D_m%28t%29%3D%5Csum_%7Bn%3D1%7D%5Em%20w_n%20t%5E%7B-n%7D&bc=White&fc=Black&im=jpg&fs=12&ff=arev&edit=0), t>0 and![equation](http://www.sciweavers.org/tex2img.php?eq=n%5Cin%5Cmathbb%7BN%7D&bc=White&fc=Black&im=jpg&fs=12&ff=arev&edit=0), then the Stokes constant is the double limit

![equation](http://www.sciweavers.org/tex2img.php?eq=%5Ctheta%20%3D%20%5Clim_%7Bt%5Cto%2B%5Cinfty%7D%20%5Clim_%7Bn%5Cto%2B%5Cinfty%7D%20e%5E%7B2%5Cpi%20i%20t%7D%20%5Comega%5CBig%28H%5E%7B-n%7D%28%5Ctilde%7BW%7D_m%28t%2Bn%29%29-H%5En%28%5Ctilde%7BW%7D_m%28t-n%29%29%2C%5Cfrac%7Bd%7D%7Bd%20t%7D%20H%5En%28%5Ctilde%7BW%7D_m%28t-n%29%29%20%5CBig%29&bc=White&fc=Black&im=jpg&fs=12&ff=arev&edit=0)

The script computes an approximation of this limit for fixed t, n and m.

The script (`Rot`)`HenonCoeffsComp.wl` computes the constants w_n. It is written in Mathematica and it is not as optimized as it should be. Each time is being run it computes 10 more coefficients and stores them in the file (`Rot`)`HenonCoeffs.dat`. Then the sript (`Rot`)`HenonCoeffsToJulia.wl` writes them in the file (`Rot`)`HenonCoeffsList.jl` in a form that JuliaLanguage can understand.


The script (`Rot`)`HenonConst.jl` computes the Stokes constant of the map. There are some comments that state which variables can be redefined safely. The result is written in the file \texttt{(`Rot`)HenonConst.dat}. Each line has the format:

`[n] [real part] [error of the real part] [imaginary part] [error of the imaginary part]`

