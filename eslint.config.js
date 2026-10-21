import tseslint from '@typescript-eslint/eslint-plugin';

export default [
  { ignores: ['dist/'] },
  ...tseslint.configs['flat/recommended-type-checked'].map((config) => ({
    ...config,
    files: ['src/**/*.ts'],
  })),
  {
    files: ['src/**/*.ts'],
    languageOptions: {
      parserOptions: { projectService: true, tsconfigRootDir: import.meta.dirname },
    },
    rules: {
      // Express error handlers must declare all four parameters, used or not.
      '@typescript-eslint/no-unused-vars': ['error', { argsIgnorePattern: '^_' }],
      eqeqeq: 'error',
      'prefer-const': 'error',
    },
  },
];
