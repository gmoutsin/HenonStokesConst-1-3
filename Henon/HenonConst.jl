using ValidatedNumerics

setprecision(Interval, 2048)

include("HenonCoeffsList.jl")

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



function Henon3(v::Vector2D)
  Vector2D( v.y*v.y*v.y*(9/4 + v.y*(-27/16 + v.y*(-81/16 + v.y*(243/32 - (2187*v.y*v.y)/256)))) + v.x*(1 + v.x*(v.y*(-45/4 + v.y*(-81/8 + v.y*(567/8 + v.y*(729/32 + (-2187/8 - (15309*v.y)/64)*v.y)))) + v.x*(27/4 + v.y*(135/4 + v.y*(405/8 + v.y*(-1701/8 + (-10935/16 - (15309*v.y)/32)*v.y))) + v.x*(-27/16 + v.y*(-1053/16 + v.y*(-13851/32 + (-3645/4 - (76545*v.y)/128)*v.y)) + v.x*(-891/16 + v.y*(-5103/16 + (-10935/16 - (15309*v.y)/32)*v.y) + v.x*(-2673/32 + v.x*(-729/16 - (2187*v.x)/256 - (2187*v.y)/32) + (-2187/8 - (15309*v.y)/64)*v.y))))) + v.y*(3 + v.y*(9/4 + v.y*(-81/4 + v.y*(81/16 + v.y*(729/16 + (-729/16 - (2187*v.y)/32)*v.y)))))) , v.x*(v.y*v.y*(45/4 + v.y*(-27/4 + v.y*(81/16 + v.y*(729/16 + (-729/16 - (2187*v.y)/32)*v.y)))) + v.x*(9/2 + v.y*(27/4 + v.y*(81/8 + v.y*(567/8 + v.y*(729/32 + (-2187/8 - (15309*v.y)/64)*v.y)))) + v.x*(63/4 + v.y*(189/4 + v.y*(405/8 + v.y*(-1701/8 + (-10935/16 - (15309*v.y)/32)*v.y))) + v.x*(27/16 + v.y*(-1053/16 + v.y*(-13851/32 + (-3645/4 - (76545*v.y)/128)*v.y)) + v.x*(-891/16 + v.y*(-5103/16 + (-10935/16 - (15309*v.y)/32)*v.y) + v.x*(-2673/32 + v.x*(-729/16 - (2187*v.x)/256 - (2187*v.y)/32) + (-2187/8 - (15309*v.y)/64)*v.y)))))) + v.y*(1 + v.y*(-3/2 + v.y*(9/4 + v.y*(27/16 + v.y*(-81/16 + v.y*(243/32 - (2187*v.y*v.y)/256)))))) )
end

function HenonInv3(v::Vector2D)
  Vector2D( v.y*v.y*v.y*(-9/4 + v.y*(-27/16 + v.y*(81/16 + v.y*(243/32 - (2187*v.y*v.y)/256)))) + v.x*(1 + v.y*(-3 + v.y*(9/4 + v.y*(81/4 + v.y*(81/16 + v.y*(-729/16 + v.y*(-729/16 + (2187*v.y)/32)))))) + v.x*(v.y*(45/4 + v.y*(-81/8 + v.y*(-567/8 + v.y*(729/32 + (2187/8 - (15309*v.y)/64)*v.y)))) + v.x*(27/4 + v.y*(-135/4 + v.y*(405/8 + v.y*(1701/8 + v.y*(-10935/16 + (15309*v.y)/32)))) + v.x*(-27/16 + v.y*(1053/16 + v.y*(-13851/32 + (3645/4 - (76545*v.y)/128)*v.y)) + v.x*(-891/16 + v.x*(-2673/32 + (2187/8 - (15309*v.y)/64)*v.y + v.x*(-729/16 - (2187*v.x)/256 + (2187*v.y)/32)) + v.y*(5103/16 + v.y*(-10935/16 + (15309*v.y)/32))))))) , v.y*(1 + v.y*(3/2 + v.y*(9/4 + v.y*(-27/16 + v.y*(-81/16 + v.y*(-243/32 + (2187*v.y*v.y)/256)))))) + v.x*(v.y*v.y*(-45/4 + v.y*(-27/4 + v.y*(-81/16 + v.y*(729/16 + (729/16 - (2187*v.y)/32)*v.y)))) + v.x*(-9/2 + v.y*(27/4 + v.y*(-81/8 + v.y*(567/8 + v.y*(-729/32 + v.y*(-2187/8 + (15309*v.y)/64))))) + v.x*(-63/4 + v.y*(189/4 + v.y*(-405/8 + v.y*(-1701/8 + (10935/16 - (15309*v.y)/32)*v.y))) + v.x*(-27/16 + v.x*(891/16 + v.y*(-5103/16 + (10935/16 - (15309*v.y)/32)*v.y) + v.x*(2673/32 + v.x*(729/16 + (2187*v.x)/256 - (2187*v.y)/32) + v.y*(-2187/8 + (15309*v.y)/64))) + v.y*(-1053/16 + v.y*(13851/32 + v.y*(-3645/4 + (76545*v.y)/128))))))) )
end



function DHenon3(v::Vector2D)
  Matrix2x2( 1 + v.x*(v.x*(81/4 + v.y*(405/4 + v.y*(1215/8 + v.y*(-5103/8 + (-32805/16 - (45927*v.y)/32)*v.y))) + v.x*(-27/4 + v.y*(-1053/4 + v.y*(-13851/8 + (-3645 - (76545*v.y)/32)*v.y)) + v.x*(-4455/16 + v.y*(-25515/16 + (-54675/16 - (76545*v.y)/32)*v.y) + v.x*(-8019/16 + v.x*(-5103/16 - (2187*v.x)/32 - (15309*v.y)/32) + (-6561/4 - (45927*v.y)/32)*v.y)))) + v.y*(-45/2 + v.y*(-81/4 + v.y*(567/4 + v.y*(729/16 + (-2187/4 - (15309*v.y)/32)*v.y))))) + v.y*(3 + v.y*(9/4 + v.y*(-81/4 + v.y*(81/16 + v.y*(729/16 + (-729/16 - (2187*v.y)/32)*v.y))))) , v.y*v.y*(27/4 + v.y*(-27/4 + v.y*(-405/16 + v.y*(729/16 - (2187*v.y*v.y)/32)))) + v.x*(3 + v.x*(-45/4 + v.y*(-81/4 + v.y*(1701/8 + v.y*(729/8 + (-10935/8 - (45927*v.y)/32)*v.y))) + v.x*(135/4 + v.y*(405/4 + v.y*(-5103/8 + (-10935/4 - (76545*v.y)/32)*v.y)) + v.x*(-1053/16 + v.y*(-13851/16 + (-10935/4 - (76545*v.y)/32)*v.y) + v.x*(-5103/16 + v.x*(-2187/8 - (2187*v.x)/32 - (15309*v.y)/32) + (-10935/8 - (45927*v.y)/32)*v.y)))) + v.y*(9/2 + v.y*(-243/4 + v.y*(81/4 + v.y*(3645/16 + (-2187/8 - (15309*v.y)/32)*v.y))))) , v.y*v.y*(45/4 + v.y*(-27/4 + v.y*(81/16 + v.y*(729/16 + (-729/16 - (2187*v.y)/32)*v.y)))) + v.x*(9 + v.x*(189/4 + v.y*(567/4 + v.y*(1215/8 + v.y*(-5103/8 + (-32805/16 - (45927*v.y)/32)*v.y))) + v.x*(27/4 + v.y*(-1053/4 + v.y*(-13851/8 + (-3645 - (76545*v.y)/32)*v.y)) + v.x*(-4455/16 + v.y*(-25515/16 + (-54675/16 - (76545*v.y)/32)*v.y) + v.x*(-8019/16 + v.x*(-5103/16 - (2187*v.x)/32 - (15309*v.y)/32) + (-6561/4 - (45927*v.y)/32)*v.y)))) + v.y*(27/2 + v.y*(81/4 + v.y*(567/4 + v.y*(729/16 + (-2187/4 - (15309*v.y)/32)*v.y))))) , 1 + v.x*(v.x*(27/4 + v.y*(81/4 + v.y*(1701/8 + v.y*(729/8 + (-10935/8 - (45927*v.y)/32)*v.y))) + v.x*(189/4 + v.y*(405/4 + v.y*(-5103/8 + (-10935/4 - (76545*v.y)/32)*v.y)) + v.x*(-1053/16 + v.y*(-13851/16 + (-10935/4 - (76545*v.y)/32)*v.y) + v.x*(-5103/16 + v.x*(-2187/8 - (2187*v.x)/32 - (15309*v.y)/32) + (-10935/8 - (45927*v.y)/32)*v.y)))) + v.y*(45/2 + v.y*(-81/4 + v.y*(81/4 + v.y*(3645/16 + (-2187/8 - (15309*v.y)/32)*v.y))))) + v.y*(-3 + v.y*(27/4 + v.y*(27/4 + v.y*(-405/16 + v.y*(729/16 - (2187*v.y*v.y)/32))))) )
end





function W(rp::Int,ip::Int)
  t = BigFloat(rp) + BigFloat(ip)*im
  sumX::Complex{BigFloat} = Complex(BigFloat(0),BigFloat(0));
  sumY::Complex{BigFloat} = Complex(BigFloat(0),BigFloat(0));
  tc::Complex{BigFloat} = Complex(BigFloat(1),BigFloat(0));
  for i in 1:Nmax-1
    tc = tc*(1 / t);
    sumX += BigFloat(coeffsX[i])*tc;
    sumY += BigFloat(coeffsY[i])*tc;
  end
  
  er = max(abs(BigFloat(coeffsX[Nmax])),abs(BigFloat(coeffsY[Nmax])))*abs(tc*(1 / t));
  
  return(Vector2D( (real(sumX) ± er) + (imag(sumX) ± er)*im, (real(sumY) ± er) + (imag(sumY) ± er)*im ))
end




function DW(rp::Int,ip::Int)
  t = BigInt(rp) + BigInt(ip)*im
  sumX::Complex{BigFloat} = Complex(BigFloat(0),BigFloat(0));
  sumY::Complex{BigFloat} = Complex(BigFloat(0),BigFloat(0));
  tc::Complex{BigFloat} = Complex(BigFloat(1),BigFloat(0))/t;
  for i in 1:Nmax-1
    tc = tc*(1 / t);
    sumX += -i*BigFloat(coeffsX[i])*tc;
    sumY += -i*BigFloat(coeffsY[i])*tc;
  end
  
  er = Nmax*max(abs(BigFloat(coeffsX[Nmax])),abs(BigFloat(coeffsY[Nmax])))*abs(tc*(1 / t));
  
  return(Vector2D( (real(sumX) ± er) + (imag(sumX) ± er)*im, (real(sumY) ± er) + (imag(sumY) ± er)*im ))
end



function StokesConstant(outfile::IOStream,N::Int64,impart::Int64)  
#   println("***********************");
  print("$(N) ");
#   println("***********************");
  ppast = W(-N,impart);
  pfuture = W(N,impart);
  pDpast = DW(-N,impart);
  
  
  for i in 1:N
    pDpast = DHenon3(ppast) * pDpast;
    ppast = Henon3(ppast);
    pfuture = HenonInv3(pfuture);
#     println(ppast);
  end
  
  
  
  cnst = determinant(pfuture - ppast,pDpast)*exp(2BigFloat(pi)*impart);
  
  
  str = "$(N)\t\t$(mid(real(cnst))))\t\t$(diam(real(cnst)))\t\t$(mid(imag(cnst))))\t\t$(diam(imag(cnst)))\n";
  
  write(outfile,str);
end



const outfile = open("HenonConst.dat","w");


for i in 1:10
  StokesConstant(outfile,200*i,50);
end



close(outfile)

println();


