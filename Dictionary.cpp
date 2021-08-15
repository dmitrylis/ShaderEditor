#include "Dictionary.h"

namespace
{

QSet<QString> CONDITIONALS { "if", "else" };

QSet<QString> STATEMENTS { "break", "return", "continue", "discard" };

QSet<QString> REPEATS { "while", "for", "do" };

QSet<QString> TYPES {
    "void"
    , "bool"
    , "bvec2"
    , "bvec3"
    , "bvec4"
    , "int"
    , "ivec2"
    , "ivec3"
    , "ivec4"
    , "uint"
    , "uvec2"
    , "uvec3"
    , "uvec4"
    , "float"
    , "vec2"
    , "vec3"
    , "vec4"
    , "double"
    , "dvec2"
    , "dvec3"
    , "dvec4"
    , "mat2"
    , "mat3"
    , "mat4"
    , "sampler1D"
    , "sampler2D"
    , "sampler3D"
    , "samplerCUBE"
    , "sampler1DShadow"
    , "sampler2DShadow"
    , "struct"
};

QSet<QString> STORAGE_CLASSES { "const", "attribute", "varying", "uniform", "in", "out", "inout" };

QSet<QString> FUNCTIONS {
    "radians"
    , "degrees"
    , "sin"
    , "cos"
    , "tan"
    , "asin"
    , "acos"
    , "atan"
    , "pow"
    , "exp2"
    , "log2"
    , "sqrt"
    , "inversesqrt"
    , "abs"
    , "sign"
    , "floor"
    , "ceil"
    , "fract"
    , "mod"
    , "min"
    , "max"
    , "clamp"
    , "mix"
    , "step"
    , "smoothstep"
    , "length"
    , "distance"
    , "dot"
    , "cross"
    , "normalize"
    , "ftransform"
    , "faceforward"
    , "reflect"
    , "matrixcompmult"
    , "lessThan"
    , "lessThanEqual"
    , "greaterThan"
    , "greaterThanEqual"
    , "equal"
    , "notEqual"
    , "any"
    , "all"
    , "not"
    , "texture1D"
    , "texture1DProj"
    , "texture1DLod"
    , "texture1DProjLod"
    , "texture2D"
    , "texture2DProj"
    , "texture2DLod"
    , "texture2DProjLod"
    , "texture3D"
    , "texture3DProj"
    , "texture3DLod"
    , "texture3DProjLod"
    , "textureCube"
    , "textureCubeLod"
    , "shadow1D"
    , "shadow1DProj"
    , "shadow1DLod"
    , "shadow1DProjLod"
    , "shadow2D"
    , "shadow2DProj"
    , "shadow2DLod"
    , "shadow2DProjLod"
    , "dFdx"
    , "dFdy"
    , "fwidth"
    , "noise1"
    , "noise2"
    , "noise3"
    , "noise4"
    , "refract"
    , "exp"
    , "log"
};

QSet<QString> STATES {
    "gl_Position"
    , "gl_PointSize"
    , "gl_ClipVertex"
    , "gl_FragCoord"
    , "gl_FrontFacing"
    , "gl_FragColor"
    , "gl_FragData"
    , "gl_FragDepth"
    , "gl_Color"
    , "gl_SecondaryColor"
    , "gl_Normal"
    , "gl_Vertex"
    , "gl_FogCoord"
    , "gl_FrontColor"
    , "gl_BackColor"
    , "gl_FrontSecondaryColor"
    , "gl_BackSecondaryColor"
    , "gl_TexCoord"
    , "gl_FogFragCoord"
    , "gl_MultiTexCoord0"
    , "gl_MultiTexCoord1"
    , "gl_MultiTexCoord2"
    , "gl_MultiTexCoord3"
    , "gl_MultiTexCoord4"
    , "gl_MultiTexCoord5"
    , "gl_MultiTexCoord6"
    , "gl_MultiTexCoord7"
};

QSet<QString> UNIFORMS {
    "gl_ModelViewMatrix"
    , "gl_ProjectionMatrix"
    , "gl_ModelViewProjectionMatrix"
    , "gl_NormalMatrix"
    , "gl_TextureMatrix"
    , "gl_NormalScale"
    , "gl_DepthRange"
    , "gl_ClipPlane"
    , "gl_Point"
    , "gl_FrontMaterial"
    , "gl_BackMaterial"
    , "gl_LightSource"
    , "gl_LightModel"
    , "gl_FrontLightModelProduct"
    , "gl_BackLightModelProduct"
    , "gl_FrontLightProduct"
    , "gl_BackLightProduct"
    , "glTextureEnvColor"
    , "gl_TextureEnvColor"
    , "gl_Fog"
    , "gl_ModelViewMatrixInverse"
    , "gl_ProjectionMatrixInverse"
    , "gl_ModelViewProjectionMatrixInverse"
    , "gl_TextureMatrixInverse"
    , "gl_ModelViewMatrixTranspose"
    , "gl_ProjectionMatrixTranspose"
    , "gl_ModelViewProjectionMatrixTranspose"
    , "gl_TextureMatrixTranspose"
    , "gl_ModelViewMatrixInverseTranspose"
    , "gl_ProjectionMatrixInverseTranspose"
    , "gl_ModelViewProjectionMatrixInverseTranspose"
    , "gl_TextureMatrixInverseTranspose"
    , "gl_EyePlane"
    , "gl_ObjectPlane"

    // Qt uniforms
    , "qt_TexCoord0"
    , "qt_Opacity"
    , "qt_MultiTexCoord0"
    , "qt_Matrix"
    , "qt_Vertex"
    , "source"
    , "coord"

    // my uniforms
    , "source"
    , "u_resolution"
    , "u_mouse"
    , "u_time"

    , "TEXCOORD"
    , "TEXCOORD0"
    , "SV_POSITION"
    , "true"
    , "false"
};

}

Dictionary::Dictionary()
{
}

QSet<QString> &Dictionary::conditionals()
{
    return ::CONDITIONALS;
}

QSet<QString> &Dictionary::statements()
{
    return ::STATEMENTS;
}

QSet<QString> &Dictionary::repeats()
{
    return ::REPEATS;
}

QSet<QString> &Dictionary::types()
{
    return ::TYPES;
}

QSet<QString> &Dictionary::starageClasses()
{
    return ::STORAGE_CLASSES;
}

QSet<QString> &Dictionary::functions()
{
    return ::FUNCTIONS;
}

QSet<QString> &Dictionary::states()
{
    return ::STATES;
}

QSet<QString> &Dictionary::uniforms()
{
    return ::UNIFORMS;
}
