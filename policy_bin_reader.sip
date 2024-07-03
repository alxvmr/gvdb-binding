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

    guint32_le start
    {
        %GetCode
            sipPy = PyLong_FromLong(sipCpp->start);
        %End
        %SetCode
            if (PyLong_Check(sipPy))
                sipCpp -> start;
            else
                sipErr = 1;
        %End
    };

    guint32_le end
    {
        %GetCode
            sipPy = PyLong_FromLong(sipCpp->end);
        %End
        %SetCode
            if (PyLong_Check(sipPy))
                sipCpp -> end;
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
            sipPy = PyLong_FromLong(sipCpp->n_bloom_words);
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
            sipPy = PyLong_FromLong(sipCpp->n_buckets);
        %End
        %SetCode
            if (PyLong_Check(sipPy))
                sipCpp -> n_buckets;
            else
                sipErr = 1;
        %End
    };
};

//////////////////////////////////////////////////////////////////
// struct gvdb_hash_item
//////////////////////////////////////////////////////////////////
struct gvdb_hash_item
{
    %TypeHeaderCode
    #include <gvdb-format.h>
    %End

    guint32_le hash_value
    {
        %GetCode
            sipPy = PyLong_FromLong(sipCpp->hash_value);
        %End
        %SetCode
            if (PyLong_Check(sipPy))
                sipCpp -> hash_value;
            else
                sipErr = 1;
        %End
    };

    guint32_le parent
    {
        %GetCode
            sipPy = PyLong_FromLong(sipCpp->parent);
        %End
        %SetCode
            if (PyLong_Check(sipPy))
                sipCpp -> parent;
            else
                sipErr = 1;
        %End
    };

    guint32_le key_start
    {
        %GetCode
            sipPy = PyLong_FromLong(sipCpp->key_start);
        %End
        %SetCode
            if (PyLong_Check(sipPy))
                sipCpp -> key_start;
            else
                sipErr = 1;
        %End
    };

    guint16_le key_size
    {
        %GetCode
            sipPy = PyLong_FromLong(sipCpp -> key_size);
        %End
        %SetCode
            if (PyLong_Check(sipPy))
                sipCpp -> key_size;
            else
                sipErr = 1;
        %End
    };

    char type     //gchar -> char
    {
        %GetCode
            sipPy = PyUnicode_FromString(&(sipCpp -> type));
        %End
        %SetCode
            if (PyUnicode_Check(sipPy))
                sipCpp -> type;
            else
                sipErr = 1;
        %End
    };

    char unused   //gchar -> char
    {
        %GetCode
            sipPy = PyUnicode_FromString(&(sipCpp -> unused));
        %End
        %SetCode
            if (PyUnicode_Check(sipPy))
                sipCpp -> unused;
            else
                sipErr = 1;
        %End
    };


    struct union_wrapper /PyName=value/
    {
        %TypeHeaderCode
            #include <gvdb-format.h>

            struct union_wrapper
            {
                union value u;
            };
        %End

        char *direct
        {
            %GetCode
            sipPy = PyBytes_AsStringAndSize(sipCpp -> u.direct, 8);
            %End

            %SetCode
            char *ptr;
            int length;

            if (PyBytes_AsStringAndSize(sipPy, &ptr, &length) == -1)
                sipErr = 1;
            else if (length != 8)
            {
                PyErr_SetString(PyExc_ValueError, "an gvdb_hash_item.value must be exactly 8 bytes");
                sipErr = 1;
            }
            else
                memcpy(sipCpp -> u.direct, ptr, 8);
            %End
        };
    };
};