// Gmsh .geo file to create a mesh of a cube LxLxd

// Mesh spacing parameters
Include "meshSpacing/meshSpacing.geo";

// Cube edge lenght
L = 1;

// Depth (out of plane)
d = 0.1;

// Points
Point(1) = {0, 0, 0, dx};
Point(2) = {L, 0, 0, dx};
Point(3) = {L, L, 0, dx};
Point(4) = {0, L, 0, dx};

// Lines
Line(1) = {1, 2};
Line(2) = {2, 3};
Line(3) = {3, 4};
Line(4) = {4, 1};

// Surface
Line Loop(6) = {4, 1, 2, 3};
Plane Surface(6) = {6};

// Force mapped meshing (triangles)
Transfinite Surface {6};
Mesh.Algorithm = 5;

// Optional: combine triangles into quadrilaterals
//Recombine Surface {6};

// Create volume by extrusion
Physical Volume("internal") = {1};
Extrude {0, 0, d} {
 Surface{6};
 Layers{1};
 Recombine;
}

// Boundary patches
Physical Surface("frontAndBack") = {28, 6};
Physical Surface("sides") = {27, 19, 15, 23};
