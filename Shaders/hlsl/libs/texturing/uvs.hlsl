#pragma once
#include "../defines.hlsl"


container(UVs,

    float2 RotateUV(float2 uvs, float angle)
    {
        angle = radians(angle) * 360;
        uvs = ( -0.5 + uvs );
        float2 csn = float2(cos(angle), sin(angle) * -1  );
        float2 sn = float2( sin(angle), cos(angle) );
        return float2( dot(uvs, csn), dot(uvs, sn) ) + 0.5;
    }


    // Triplanar UVs (hard edges / no blending)
    float2 TriPlanarUvs_NoBlend(
        float scale,    // Scale in meters
        float3 world_pos,    // Position in world space
        float3 vert_nml,    // World space vertex normals
        float angle     // Rotation of the UVs
        )    
    {
        float2 rg = lerp( world_pos.xy, world_pos.yz, round( abs( vert_nml.x ) ) );
        float2 gb = lerp( rg, world_pos.xz, round( abs( vert_nml.y ) ) );
        float2 output = ( 1 + float2( gb.x, gb.y ) ) / scale;

        [branch]
        if(angle != 0.0)
        {
            output = RotateUV( output, angle );
        }
        
        return output;
    }


    // Get flipbook uv coordinates from input cell id
    float2 FlipbookUV(float2 uvs, int2 cells_count, float fraction)
    {
        float2 output = float2(0.0, 0.0);

        float numCells = cells_count.x * cells_count.y;

        output = frac(1.0 - fraction);
        output *= float2(1.0 - numCells, cells_count.y);
        output /= cells_count;
        output += (uvs / cells_count);

        return output;
    }


    // 
    float2 ParallaxUV(float2 uvs, float3 view_dir, float height, float ratio)
    {
        view_dir = view_dir * float3(1,-1,1);
        float h = ratio * height * 0.01;
        return uvs + view_dir.xy * h;
    }


    //
    /*float2 PixellateUV(float2 uvs, float strength)    
    {
        return (floor((_ScreenParams*strength)*uvs))/(_ScreenParams*strength);
    }*/


    // https://medium.com/@bgolus/normal-mapping-for-a-triplanar-shader-10bf39dca05a
    float2 ASymTriplanarUV(float3 normal)
    {
        float3 blend = 0.0f;

        float2 xzBlend = abs(normalize(normal.xz));
        blend.xz = max(0.0f, xzBlend - 0.67f);
        blend.xz *= (1.0f - blend.y);

        return xzBlend;
    }

)
