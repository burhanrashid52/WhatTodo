import {FeatureDescriptor} from '@vyuh/sanity-schema-core';
import {RouteDescriptor} from '@vyuh/sanity-schema-system';
import {GroupCardContentDescriptor, GroupCardContentSchemaBuilder} from './group-card-content.ts';
import {CardTileContentDescriptor, CardTileContentSchemaBuilder} from "./card-tile-content.ts";

export const todoSchema = new FeatureDescriptor({
    name: 'todoSchema',
    title: 'Todo Schema',
    description: 'Schema for the Todo Schema feature',
    contents: [
        new RouteDescriptor({
            regionItems: [
                {type: GroupCardContentDescriptor.schemaName},
                {type: CardTileContentDescriptor.schemaName},
            ],
        }),
        new GroupCardContentDescriptor(),
        new CardTileContentDescriptor(),
    ],
    contentSchemaBuilders: [
        new GroupCardContentSchemaBuilder(),
        new CardTileContentSchemaBuilder(),
    ],
});
