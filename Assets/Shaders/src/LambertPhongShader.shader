Shader "Unlit/LambertPhongShader"
{
	Properties
	{
		_MainTex("Texture", 2D) = "white" {}
	}
		SubShader
	{
	Tags { "RenderType" = "Opaque" }
	LOD 100
	Pass
	{
		CGPROGRAM
		#pragma vertex vert // runs every vertex
		#pragma fragment frag // runs every pixel
		#pragma multi_compile_fog // makes fog work
		#include "UnityCG.cginc"
		struct appdata
		{
			float4 vertex : POSITION;
			float4 normal : NORMAL;
			float2 uv : TEXCOORD0;
		};

		struct v2f
		{
			float4 vertex : SV_POSITION;
			float4 normal : NORMAL;
			float2 uv : TEXCOORD0;

			UNITY_FOG_COORDS(1)
		};

		sampler2D _MainTex;
		float4 _MainTex_ST;
		v2f vert(appdata v)
		{
			v2f o;
			o.vertex = UnityObjectToClipPos(v.vertex);
			o.normal = normalize(mul(unity_ObjectToWorld, v.normal));
			o.uv = TRANSFORM_TEX(v.uv, _MainTex);
			UNITY_TRANSFER_FOG(o,o.vertex);
			return o;
		}
		fixed4 frag(v2f i) : SV_Target
		{
			float ambient = 0.1f;
			float lambert = saturate(dot(i.normal, _WorldSpaceLightPos0));
			float specular = saturate(dot(reflect(_WorldSpaceLightPos0, i.normal), -_WorldSpaceCameraPos));
			// sample the texture
			fixed4 col = tex2D(_MainTex, i.uv) * (ambient + lambert + specular);
			// apply fog
			UNITY_APPLY_FOG(i.fogCoord, col);
			return col;
		}
		ENDCG
		}
	}
}