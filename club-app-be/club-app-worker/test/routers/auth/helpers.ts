import { expect } from 'chai'
import { hash, verifyHash } from '../../../src/routers/auth/helpers'


describe('auth helpers', () => {
    describe('refresh token hashing', () => {
    it('should not hash two same passwords the same (due to random salt)', async () => {
        const PASSWORD = '123456'

        const password1 = await hash(PASSWORD)
        const password2 = await hash(PASSWORD)

        expect(password1 !== password2).to.be.true
    }),
    it('should verify hashed passwords', async () => {
        const PASSWORD = '123456'

        const hashed = await hash(PASSWORD)

        expect(await verifyHash(PASSWORD, hashed)).to.be.true
    }), 
    it('should return false with different passwords', async () => {
        const PASSWORD_ONE = 'password'
        const PASSWORD_TWO = 'password2'

        const hashed = await hash(PASSWORD_ONE)

        expect(await verifyHash(PASSWORD_TWO, hashed)).to.be.false
    })
})

})
