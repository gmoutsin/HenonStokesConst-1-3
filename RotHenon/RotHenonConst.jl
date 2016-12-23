using ValidatedNumerics

setprecision(Interval, 2048)

include("RotHenonCoeffsList.jl")

import Base:
  +, *, -, /, show, convert


immutable Vector2D
  x::Complex{ValidatedNumerics.Interval{BigFloat}}
  y::Complex{ValidatedNumerics.Interval{BigFloat}}
end


immutable Matrix2x2
  a11::Complex{ValidatedNumerics.Interval{BigFloat}}
  a12::Complex{ValidatedNumerics.Interval{BigFloat}}
  a21::Complex{ValidatedNumerics.Interval{BigFloat}}
  a22::Complex{ValidatedNumerics.Interval{BigFloat}}
end



Vector2D{T1,T2}(x::T1,y::T2) = Vector2D( Complex(@interval(x)) , Complex(@interval(y)) )
Matrix2x2{T1,T2,T3,T4}(a11::T1,a12::T2,a21::T3,a22::T4) = Matrix2x2( Complex(@interval(a11)) , Complex(@interval(a12)), Complex(@interval(a21)) , Complex(@interval(a22)) )

# convert(::Type{ValidatedNumerics.Interval{BigFloat}}, v::Complex{ValidatedNumerics.Interval{BigFloat}}) = v

+(v::Vector2D,w::Vector2D) = Vector2D(v.x + w.x,v.y + w.y)
-(v::Vector2D,w::Vector2D) = Vector2D(v.x - w.x,v.y - w.y)
*(c::Number,v::Vector2D) = Vector2D(c*v.x,c*v.y)
*(v::Vector2D,c::Number) = Vector2D(c*v.x,c*v.y)
*(v::Vector2D,w::Vector2D) = Vector2D(v.x*w.x + v.y*w.y) 
/(v::Vector2D,c::Number) = Vector2D(v.x/c,v.y/c)
show(io::IO,v::Vector2D) = print(io,"($(v.x),$(v.y))")
determinant(v::Vector2D,w::Vector2D) = v.x*w.y - v.y*w.x


*(A::Matrix2x2,B::Matrix2x2) = Matrix2x2(A.a11*B.a11 + A.a12*B.a21, A.a11*B.a12 + A.a12*B.a22, A.a21*B.a11 + A.a22*B.a21, A.a21*B.a12 + A.a22*B.a22) 

*(A::Matrix2x2,v::Vector2D) = Vector2D(A.a11*v.x + A.a12*v.y, A.a21*v.x + A.a22*v.y )

prettyPrint(v::Vector2D) = println("( $(mid(real(v.x))) ± $(diam(real(v.x))/2) \n $(mid(imag(v.x))) ± $(diam(imag(v.x))/2) \n:\n $(mid(real(v.y))) ± $(diam(real(v.y))/2) \n $(mid(imag(v.y))) ± $(diam(imag(v.y))/2) )")


const sqrt3 = sqrt(BigInt(3))





function Henon3(v::Vector2D)
  Vector2D(   v.y*v.y*v.y*((9*sqrt3)/16 + (27*sqrt3*v.y)/128) + v.x*(1 + v.y*(-3/2 + (9/16 + (27*v.y)/32)*v.y) + v.x*(v.y*((-3*sqrt3)/16 + v.y*((-81*sqrt3)/64 - (27*sqrt3*v.y)/32)) + v.x*(21/16 + (-27/32 - (81*v.y)/32)*v.y + v.x*((27*sqrt3)/128 + v.y*((27*sqrt3)/32 + (81*sqrt3*v.y)/64) + v.x*(9/32 + (81*v.y)/32 + v.x*((-9*sqrt3)/64 + v.x*(-27/32 + (27*sqrt3*v.x)/128) - (27*sqrt3*v.y)/32)))))),  v.y*(1 + v.y*(3/4 + (9/16 + (27*v.y)/128)*v.y)) + v.x*(v.y*v.y*((3*sqrt3)/16 + (9*sqrt3*v.y)/32) + v.x*(-3/4 + v.y*(-27/16 + (-81/64 - (27*v.y)/32)*v.y) + v.x*(-sqrt3/16 + v.y*((-9*sqrt3)/32 - (27*sqrt3*v.y)/32) + v.x*(123/128 + v.y*(27/32 + (81*v.y)/64) + v.x*((3*sqrt3)/32 + v.x*(-9/64 + ((-9*sqrt3)/32 + (27*v.x)/128)*v.x - (27*v.y)/32) + (27*sqrt3*v.y)/32)))))  )
end

function HenonInv3(v::Vector2D)
  Vector2D(   v.y*v.y*v.y*((-9*sqrt3)/16 + (27*sqrt3*v.y)/128) + v.x*(1 + v.y*(3/2 + (9/16 - (27*v.y)/32)*v.y) + v.x*(v.x*(-3/16 + (3*sqrt3*v.x)/128 - (9*v.y)/32) + v.y*((3*sqrt3)/16 + (27*sqrt3*v.y)/64))),   v.y*(1 + v.y*(-3/4 + v.y*(9/16 + v.y*(-27/128 + v.y*v.y*(243/256 + (-729/1024 + (2187*v.y)/16384)*v.y))))) + v.x*(v.y*v.y*((-3*sqrt3)/16 + v.y*((-27*sqrt3)/32 + v.y*((-81*sqrt3)/64 + v.y*v.y*((1215*sqrt3)/1024 - (729*sqrt3*v.y)/2048)))) + v.x*(3/4 + v.y*(45/16 + v.y*(189/64 + v.y*v.y*(-729/256 + v.y*(-2187/1024 + (5103*v.y)/4096)))) + v.x*(sqrt3/16 + v.y*((15*sqrt3)/32 + v.y*((45*sqrt3)/32 + v.y*((27*sqrt3)/16 + v.y*((405*sqrt3)/1024 - (1701*sqrt3*v.y)/2048)))) + v.x*(-51/128 + v.y*(-9/8 + v.y*(-243/256 + v.y*(405/1024 + (8505*v.y)/8192))) + v.x*((3*sqrt3)/64 + v.y*v.y*((-243*sqrt3)/1024 - (567*sqrt3*v.y)/2048) + v.x*(9/256 + (135/1024 + (567*v.y)/4096)*v.y + v.x*((-9*sqrt3)/1024 + (27*v.x)/16384 - (27*sqrt3*v.y)/2048))))))) )
end



function DHenon3(v::Vector2D)
  Matrix2x2(   1 + v.y*(-3/2 + (9/16 + (27*v.y)/32)*v.y) + v.x*(v.y*((-3*sqrt3)/8 + v.y*((-81*sqrt3)/32 - (27*sqrt3*v.y)/16)) + v.x*(63/16 + (-81/32 - (243*v.y)/32)*v.y + v.x*((27*sqrt3)/32 + v.y*((27*sqrt3)/8 + (81*sqrt3*v.y)/16) + v.x*(45/32 + (405*v.y)/32 + v.x*((-27*sqrt3)/32 + v.x*(-189/32 + (27*sqrt3*v.x)/16) - (81*sqrt3*v.y)/16))))), v.y*v.y*((27*sqrt3)/16 + (27*sqrt3*v.y)/32) + v.x*(-3/2 + v.y*(9/8 + (81*v.y)/32) + v.x*((-3*sqrt3)/16 + v.y*((-81*sqrt3)/32 - (81*sqrt3*v.y)/32) + v.x*(-27/32 - (81*v.y)/16 + v.x*((27*sqrt3)/32 + v.x*(81/32 - (27*sqrt3*v.x)/32) + (81*sqrt3*v.y)/32)))), v.y*v.y*((3*sqrt3)/16 + (9*sqrt3*v.y)/32) + v.x*(-3/2 + v.y*(-27/8 + (-81/32 - (27*v.y)/16)*v.y) + v.x*((-3*sqrt3)/16 + v.y*((-27*sqrt3)/32 - (81*sqrt3*v.y)/32) + v.x*(123/32 + v.y*(27/8 + (81*v.y)/16) + v.x*((15*sqrt3)/32 + v.x*(-27/32 + v.x*((-63*sqrt3)/32 + (27*v.x)/16) - (81*v.y)/16) + (135*sqrt3*v.y)/32)))), 1 + v.y*(3/2 + (27/16 + (27*v.y)/32)*v.y) + v.x*(v.y*((3*sqrt3)/8 + (27*sqrt3*v.y)/32) + v.x*(-27/16 + (-81/32 - (81*v.y)/32)*v.y + v.x*((-9*sqrt3)/32 - (27*sqrt3*v.y)/16 + v.x*(27/32 + ((27*sqrt3)/32 - (27*v.x)/32)*v.x + (81*v.y)/32)))) )
end




########################################################################
#
#   If you want to chance the number of terms of the asymptotic series
#   used uncomment the next line and set Nmax. Nmax was declared
#   a constant and Julia will complain but as long as the new value
#   is an integer there will be no problems
#
# Nmax = 100
#
########################################################################





function W(rp::Int,ip::Int)
  t = BigFloat(rp) + BigFloat(ip)*im
  sumX::Complex{BigFloat} = Complex(BigFloat(0),BigFloat(0));
  sumY::Complex{BigFloat} = Complex(BigFloat(0),BigFloat(0));
  tc::Complex{BigFloat} = Complex(BigFloat(1),BigFloat(0));
  for i in 1:Nmax-1
    tc = tc*(1 / t);
    sumX += BigFloat(coeffsX[i])*tc/sqrt3;
    sumY += BigFloat(coeffsY[i])*tc;
  end
  
  er = max(abs(BigFloat(coeffsX[Nmax])/sqrt3),abs(BigFloat(coeffsY[Nmax])))*abs(tc*(1 / t));
  
  return(Vector2D( (real(sumX) ± er) + (imag(sumX) ± er)*im, (real(sumY) ± er) + (imag(sumY) ± er)*im ))
end




function DW(rp::Int,ip::Int)
  t = BigInt(rp) + BigInt(ip)*im
  sumX::Complex{BigFloat} = Complex(BigFloat(0),BigFloat(0));
  sumY::Complex{BigFloat} = Complex(BigFloat(0),BigFloat(0));
  tc::Complex{BigFloat} = Complex(BigFloat(1),BigFloat(0))/t;
  for i in 1:Nmax-1
    tc = tc*(1 / t);
    sumX += -i*BigFloat(coeffsX[i])*tc/sqrt3;
    sumY += -i*BigFloat(coeffsY[i])*tc;
  end
  
  er = Nmax*max(abs(BigFloat(coeffsX[Nmax])/sqrt3),abs(BigFloat(coeffsY[Nmax])))*abs(tc*(1 / t));
  
  return(Vector2D( (real(sumX) ± er) + (imag(sumX) ± er)*im, (real(sumY) ± er) + (imag(sumY) ± er)*im ))
end



function StokesConstant(outfile::IOStream,N::Int64,impart::Int64)  
  print("$(N) ");
  ppast = W(-N,impart);
  pfuture = W(N,impart);
  pDpast = DW(-N,impart);
  
  
  for i in 1:N
    pDpast = DHenon3(ppast) * pDpast;
    ppast = Henon3(ppast);
    pfuture = HenonInv3(pfuture);
  end
  
  
  
  cnst = determinant(pfuture - ppast,pDpast)*exp(2BigFloat(pi)*impart);
  
  
  str = "$(N)\t\t$(mid(real(cnst))))\t\t$(diam(real(cnst)))\t\t$(mid(imag(cnst))))\t\t$(diam(imag(cnst)))\n";
  
  write(outfile,str);
end



const outfile = open("RotHenonConst.dat","w");




########################################################################
#
#   The following two variables can be chaged safely
#   The Stokes constant is approximated at t = impart*i.
#

const impart = 100

const steps = 10

########################################################################


for i in 1:steps
  StokesConstant(outfile,200*i,impart);
end



close(outfile)

println();


