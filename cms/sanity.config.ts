import {defineConfig} from 'sanity'
import {vyuh} from '@vyuh/sanity-plugin-structure'
import {system} from '@vyuh/sanity-schema-system'
import {schemaTypes} from './schemaTypes'
import {todoSchema} from '../features/todo-schema'

export default defineConfig({
    name: 'default',
    title: 'what_todo',

    projectId: '1bnautyt',
    dataset: 'production',

    plugins: [
        vyuh({
            features: [
                system,
                todoSchema,
            ],
        }),
    ],

    schema: {
        types: schemaTypes,
    },
})
