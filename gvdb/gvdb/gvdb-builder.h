/*
 * Copyright © 2010 Codethink Limited
 *
 * SPDX-License-Identifier: LGPL-2.1-or-later
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 2.1 of the License, or (at your option) any later version.
 *
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public
 * License along with this library; if not, see <http://www.gnu.org/licenses/>.
 *
 * Author: Ryan Lortie <desrt@desrt.ca>
 */

#ifndef __gvdb_builder_h__
#define __gvdb_builder_h__

#include <gio/gio.h>
#include <glib-object.h>

typedef struct _GvdbItem GvdbItem;

#define GVDB_TYPE_ITEM (gvdb_item_get_type())

GType                   gvdb_item_get_type                              (void);


GvdbItem *              gvdb_item_copy                                  (GvdbItem      *data);


GvdbItem *              gvdb_item_new                                   (void);


void                    gvdb_item_custom_free                           (GvdbItem      *data);


GHashTable *            gvdb_hash_table_new                             (GHashTable    *parent,
                                                                         const gchar   *key);


GvdbItem *              gvdb_hash_table_insert                          (GHashTable    *table,
                                                                         const gchar   *key);

void                    gvdb_hash_table_insert_string                   (GHashTable    *table,
                                                                         const gchar   *key,
                                                                         const gchar   *value);


void                    gvdb_item_set_value                             (GvdbItem      *item,
                                                                         GVariant      *value);

void                    gvdb_item_set_hash_table                        (GvdbItem      *item,
                                                                         GHashTable    *table);

void                    gvdb_item_set_parent                            (GvdbItem      *item,
                                                                         GvdbItem      *parent);


gboolean                gvdb_table_write_contents                       (GHashTable     *table,
                                                                         const gchar    *filename,
                                                                         gboolean        byteswap,
                                                                         GError        **error);

void                    gvdb_table_write_contents_async                 (GHashTable          *table,
                                                                         const gchar         *filename,
                                                                         gboolean             byteswap,
                                                                         GCancellable        *cancellable,
                                                                         GAsyncReadyCallback  callback,
                                                                         gpointer             user_data);

gboolean                gvdb_table_write_contents_finish                (GHashTable          *table,
                                                                         GAsyncResult        *result,
                                                                         GError             **error);


GBytes *                gvdb_table_get_contents                         (GHashTable          *table,
                                                                         gboolean             byteswap);

#endif /* __gvdb_builder_h__ */
