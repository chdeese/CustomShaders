using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class SpinObject : MonoBehaviour
{
    [SerializeField]
    private Vector3 _deltaRotation;
    private void FixedUpdate()
    {
        Vector3 eulers = transform.localRotation.eulerAngles;

        eulers.x = eulers.x + (_deltaRotation.x * Time.fixedDeltaTime);
        eulers.y = eulers.y + (_deltaRotation.y * Time.fixedDeltaTime);
        eulers.z = eulers.z + (_deltaRotation.z * Time.fixedDeltaTime);

        transform.localRotation = Quaternion.Euler(eulers);
    }
}
