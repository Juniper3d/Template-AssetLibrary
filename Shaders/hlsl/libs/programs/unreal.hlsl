/*#pragma once
#include "../defines.hlsl"


container(Unreal,

    // Index List:
    // 0 : Scene Colour
    // 1 : Scene Depth
    // 2 : Diffuse Colour
    // 3 : Specular Colour Colour
    // 4 : Subsurface Colour
    // 5 : Base Colour (lighting)
    // 6 : Specular (lighting)
    // 7 : Metallic
    // 8 : Normal (World Space)
    // 9 : Separate Translucency
    // 10 : Opacity
    // 11 : Roughness
    // 12 : Material AO
    // 13 : Custom depth
    // 14 : PP Input 0
    // 15 : PP Input 1
    // 16 : PP Input 2
    // 17 : PP Input 3
    // 18 : PP Input 4
    // 19 : PP Input 5
    // 20 : PP Input 6
    // 21 : Decal Mask
    // 22 : Shading Model
    // 23 : Ambient Occlusion
    // 24 : Custom Stencil
    // 25 : Base Colour (GBuffer)
    // 26 : Specular (GBuffer)
    // float4 SampleSceneColor(float2 uv, bool bilinear)

    #define SampleSceneTexture(uv, index, flitered)\
        SceneTextureLookup(uv, index, filtered)

    #define SceneTextureUV(index)\
        GetDefaultSceneTextureUV(Parameters, index)

)*/