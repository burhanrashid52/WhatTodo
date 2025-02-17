import {defineConfig} from 'sanity'
import {vyuh} from '@vyuh/sanity-plugin-structure'
import {system} from '@vyuh/sanity-schema-system'
import {schemaTypes} from './schemaTypes'
import {tileSchema} from '../features/tile/schema'

export default defineConfig({
    name: 'default',
    title: 'what_todo',

    projectId: '1bnautyt',
    dataset: 'production',

    plugins: [
        vyuh({
            features: [
                system,
                tileSchema,
            ],
        }),
    ],

    schema: {
        types: schemaTypes,
    },
})
