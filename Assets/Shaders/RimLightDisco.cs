using System.Collections;
using System.Collections.Generic;
using UnityEngine;

[RequireComponent(typeof(Renderer))]
public class RimLightDisco : MonoBehaviour
{
    private Renderer _renderer;
    [SerializeField, Range(0, 10)]
    private float _speed = 1;
    private void Awake()
    {
        _renderer = GetComponent<Renderer>();
    }

    private void Update()
    {
        if (!_renderer || !_renderer.material)
            return;

        float value = (Mathf.Sin(Time.time * _speed) + 1) / 2;
        _renderer.material.SetFloat("_RimPower", value * 9 + 1);
        _renderer.material.SetFloat("_RimPower", value * 10);

    }
}
