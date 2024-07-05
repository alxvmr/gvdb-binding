%Module(name=gvdb.format, language="C++")

//////////////////////////////////////////////////////////////////
// guint32_le
/////////////////////////////////////////////////////////////////
%MappedType guint32_le
{
    %TypeHeaderCode
    #include <gvdb-format.h>
    %End

    %ConvertFromTypeCode
        PyObject* pSize;
        pSize = PyLong_FromUnsignedLong(sipCpp->value);  
        return pSize;
    %End

    %ConvertToTypeCode
        if (sipIsErr == NULL)
        {
            return (PyLong_Check(sipPy));
        }

        if (sipPy == Py_None)
        {
            *sipCppPtr = new guint32_le();
            return 1;
        }

        if (PyLong_Check(sipPy))
        {
            guint32_le *le = new guint32_le();
            le->value = PyLong_AS_LONG(sipPy);
            *sipCppPtr = le;
            return 1;
        }
        return 0;
    %End
};

//////////////////////////////////////////////////////////////////
// guint16_le
//////////////////////////////////////////////////////////////////

%MappedType guint16_le
    {
    %TypeHeaderCode
    #include <gvdb-format.h>
    %End

    %ConvertFromTypeCode
        PyObject* pSize;
        pSize = PyLong_FromUnsignedLong(sipCpp->value);  
        return pSize;
    %End

    %ConvertToTypeCode
        if (sipIsErr == NULL)
        {
            return (PyLong_Check(sipPy));
        }

        if (sipPy == Py_None)
        {
            *sipCppPtr = new guint16_le();
            return 1;
        }

        if (PyLong_Check(sipPy))
        {
            guint16_le *le = new guint16_le();
            le->value = PyLong_AS_LONG(sipPy);
            *sipCppPtr = le;
            return 1;
        }
        return 0;
    %End
};

//////////////////////////////////////////////////////////////////
// struct gvdb_pointer
//////////////////////////////////////////////////////////////////
struct gvdb_pointer
{
    %TypeHeaderCode
    #include <gvdb-format.h>
    %End

    guint32_le start{
        %GetCode
            sipPy = PyLong_FromUnsignedLong(sipCpp->start.value);
        %End
        %SetCode
            if (PyLong_Check(sipPy))
                sipCpp->start.value;
            else
                sipErr = 1;
        %End
    };

    guint32_le end
    {
        %GetCode
            sipPy = PyLong_FromUnsignedLong(sipCpp->end.value);
        %End
        %SetCode
            if (PyLong_Check(sipPy))
                sipCpp->end.value;
            else
                sipErr = 1;
        %End
    };
};

//////////////////////////////////////////////////////////////////
// struct gvdb_hash_header
//////////////////////////////////////////////////////////////////
struct gvdb_hash_header
{
    %TypeHeaderCode
    #include <gvdb-format.h>
    %End

    guint32_le n_bloom_words
    {
        %GetCode
            sipPy = PyLong_FromLong(sipCpp->n_bloom_words.value);
        %End
        %SetCode
            if (PyLong_Check(sipPy))
                sipCpp -> n_bloom_words;
            else
                sipErr = 1;
        %End
    };

    guint32_le n_buckets
    {
        %GetCode
            sipPy = PyLong_FromLong(sipCpp->n_buckets.value);
        %End
        %SetCode
            if (PyLong_Check(sipPy))
                sipCpp -> n_buckets;
            else
                sipErr = 1;
        %End
    };
};

struct value_union_wrapper
{
    %TypeHeaderCode
    #include <gvdb-format.h>

    struct value_union_wrapper
    {
        union value_t wrapped_value;
    };
    %End

    char direct {
        %GetCode
            sipPy = PyUnicode_FromStringAndSize(sipCpp->wrapped_value.direct, 8);
        %End
        %SetCode
                char *ptr;
                long int length;

                if (PyBytes_AsStringAndSize(sipPy, &ptr, &length) == -1)
                {
                    sipErr = 1;
                }
                else if (length != 8)
                {
                    PyErr_SetString(PyExc_ValueError, "an value.direct must be exactly 8 bytes");
                    sipErr = 1;
                }
                else
                {
                    memcpy(sipCpp->wrapped_value.direct, ptr, 8);
                }
        %End
    };

    struct gvdb_pointer pointer
    {
        %GetCode
            sipPy = sipConvertFromType(sipCpp, sipType_gvdb_pointer, NULL);
        %End
        %SetCode
            sipCpp = reinterpret_cast<value_union_wrapper*>(sipConvertToType(sipPy, sipType_gvdb_pointer, 0, 0, 0, &sipErr));
        %End
    };
};